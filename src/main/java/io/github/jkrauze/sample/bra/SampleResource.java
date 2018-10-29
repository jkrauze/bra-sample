package io.github.jkrauze.sample.bra;

import lombok.Builder;
import lombok.Data;
import org.springframework.data.annotation.Id;

@Data
@Builder
public class SampleResource {
    @Id
    private long id;
    private String name;
}
