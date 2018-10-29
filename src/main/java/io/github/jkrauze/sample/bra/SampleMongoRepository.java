package io.github.jkrauze.sample.bra;

import org.springframework.data.mongodb.repository.ReactiveMongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SampleMongoRepository extends ReactiveMongoRepository<SampleResource, Long> {
}
