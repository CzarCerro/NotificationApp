package io.javabrains.tokens;

import org.springframework.data.repository.CrudRepository;

import io.javabrains.tokens.Token;

public interface TokenRepository extends CrudRepository<Token, String>{

}

