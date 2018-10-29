package io.github.jkrauze.sample.bra;

import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

@RestController
@RequestMapping(path = "/mongo-items")
public class SampleMongoController {

    private SampleMongoRepository repo;

    public SampleMongoController(SampleMongoRepository repo) {
        this.repo = repo;
    }

    @PostMapping
    public Mono<SampleResource> create(@RequestBody Mono<SampleResource> request) {
        return repo.count().flatMap(id -> request.map(res -> {
            res.setId(id);
            return res;
        })).flatMap(repo::insert);
    }

    @GetMapping
    public Flux<SampleResource> list() {
        return repo.findAll();
    }

    @GetMapping(path = "/{id}")
    public Mono<SampleResource> get(@PathVariable("id") Long id) {
        return repo.findById(id);
    }

    @PutMapping(path = "/{id}")
    public Mono<SampleResource> update(@PathVariable Long id, @RequestBody Mono<SampleResource> request) {
        return request.map(r -> {
            r.setId(id);
            return r;
        }).flatMap(repo::save);
    }

    @DeleteMapping(path = "/{id}")
    public Mono<Void> delete(@PathVariable Long id) {
        return Mono.just(id).flatMap(repo::deleteById);
    }

}
