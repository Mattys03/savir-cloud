package com.savir.catalog.controller;

import com.savir.catalog.model.Client;
import com.savir.catalog.service.AuthClient;
import com.savir.catalog.service.ClientService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;

/**
 * Controller (MVC + GRASP Controller) - Endpoints REST de Clientes.
 * Demonstra comunicação entre microserviços via AuthClient.
 */
@RestController
@RequestMapping("/api/clients")
@CrossOrigin(origins = "*")
public class ClientController {

    private final ClientService clientService;
    private final AuthClient authClient;

    public ClientController(ClientService clientService, AuthClient authClient) {
        this.clientService = clientService;
        this.authClient = authClient;
    }

    @GetMapping
    public List<Client> getAll() { return clientService.findAll(); }

    @GetMapping("/{id}")
    public ResponseEntity<Client> getById(@PathVariable String id) {
        return clientService.findById(id).map(ResponseEntity::ok).orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<?> create(@RequestBody Client client, @RequestHeader(value = "user-id", required = false) String userId) {
        client.setCreatedBy(userId);
        return ResponseEntity.ok(clientService.create(client));
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> update(@PathVariable String id, @RequestBody Client client, @RequestHeader(value = "user-id", required = false) String userId) {
        try {
            Client existing = clientService.findById(id).orElseThrow(() -> new RuntimeException("Não encontrado"));
            boolean isOwner = existing.getCreatedBy() != null && existing.getCreatedBy().equals(userId);
            boolean isAdmin = userId != null && authClient.isAdministrator(userId);
            if (!isOwner && !isAdmin) {
                return ResponseEntity.status(403).body(Map.of("error", "Acesso negado. Apenas o criador ou administradores podem modificar este registro."));
            }
            return ResponseEntity.ok(clientService.update(id, client));
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable String id, @RequestHeader(value = "user-id", required = false) String userId) {
        try {
            Client existing = clientService.findById(id).orElseThrow(() -> new RuntimeException("Não encontrado"));
            boolean isOwner = existing.getCreatedBy() != null && existing.getCreatedBy().equals(userId);
            boolean isAdmin = userId != null && authClient.isAdministrator(userId);
            if (!isOwner && !isAdmin) {
                return ResponseEntity.status(403).body(Map.of("error", "Acesso negado. Apenas o criador ou administradores podem excluir este registro."));
            }
            clientService.delete(id);
            return ResponseEntity.ok(Map.of("success", true, "message", "Cliente excluído com sucesso"));
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }
}
