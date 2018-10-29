package io.github.jkrauze.sample.bra;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Service
public class SampleService {

    private Map<Long, SampleResource> map = new ConcurrentHashMap<>();

    public Mono<SampleResource> get(Long id) {
        return map.containsKey(id) ? Mono.just(map.get(id)) : Mono.error(new ResponseStatusException(HttpStatus.NOT_FOUND));
    }

    public Flux<SampleResource> list() {
        return Flux.fromIterable(map.values());
    }

    public Mono<SampleResource> create(SampleResource entity) {
        entity.setId(map.keySet().stream().mapToLong(Long::longValue).max().orElse(0) + 1);
        map.put(entity.getId(), entity);
        return Mono.just(entity);
    }

    public Mono<SampleResource> update(Long id, SampleResource entity) {
        entity.setId(id);
        map.put(id, entity);
        return Mono.just(entity);
    }

    public Mono<Void> delete(Long id) {
        map.remove(id);
        return Mono.empty();
    }

}
