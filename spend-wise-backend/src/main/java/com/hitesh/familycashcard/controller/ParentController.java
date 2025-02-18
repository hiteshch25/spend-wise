package com.hitesh.familycashcard.controller;

import com.hitesh.familycashcard.model.LoginDTO;
import com.hitesh.familycashcard.model.ParentModel;
import com.hitesh.familycashcard.service.ParentService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@CrossOrigin(origins = "*")
@RestController
public class ParentController {

        @Autowired
        private ParentService parentService;

        @Autowired
        private AuthenticationManager authenticationManager;

        @PostMapping("/register")
        public ResponseEntity<?> register(@Valid @RequestBody ParentModel parent){
                ParentModel create= parentService.register(parent);
                try {
                        return ResponseEntity.ok(create);
                } catch (IllegalArgumentException e) {
                        return ResponseEntity.badRequest().body(e.getMessage());
                }
        }



        @GetMapping("/parent/{id}")
        public ResponseEntity<?> getParentById(@PathVariable String id){
                Optional<ParentModel> parent=  parentService.getParentById(id);
                if(parent.isEmpty())
                        return new ResponseEntity<>("Parent is not registered with id "+id, HttpStatus.NOT_FOUND);
                else
                        return new ResponseEntity<>("Parent is registered with id "+parent.get(), HttpStatus.OK);
        }

        @PostMapping("/login")
        public ResponseEntity<?> login(@Valid @RequestBody LoginDTO request) {
                try {
                        Authentication authentication = authenticationManager.authenticate(
                                new UsernamePasswordAuthenticationToken(request.getEmail(), request.getPassword())
                        );
                        UserDetails userDetails = (UserDetails) authentication.getPrincipal();
                        Map<String, Object> response = new HashMap<>();
                        response.put("message", "Login successful");
                        response.put("user", userDetails.getUsername());
                        return ResponseEntity.ok(response);
                } catch (Exception e) {
                        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid credentials");
                }
        }
        



}