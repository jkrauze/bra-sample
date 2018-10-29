package io.github.jkrauze.sample.bra;

import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

@RestController
@RequestMapping(path = "/items")
public class SampleController {

    private SampleService service;

    public SampleController(SampleService service) {
        this.service = service;
    }

    @PostMapping
    public Mono<SampleResource> create(@RequestBody Mono<SampleResource> request) {
        return request.flatMap(service::create);
    }

    @GetMapping
    public Flux<SampleResource> list() {
        return service.list();
    }

    @GetMapping(path = "/{id}")
    public Mono<SampleResource> get(@PathVariable("id") Long id) {
        return service.get(id);
    }

    @PutMapping(path = "/{id}")
    public Mono<SampleResource> update(@PathVariable Long id, @RequestBody Mono<SampleResource> request) {
        return request.flatMap(resource -> service.update(id, resource));
    }

    @DeleteMapping(path = "/{id}")
    public Mono<Void> delete(@PathVariable Long id) {
        return Mono.just(id).flatMap(service::delete);
    }

}
