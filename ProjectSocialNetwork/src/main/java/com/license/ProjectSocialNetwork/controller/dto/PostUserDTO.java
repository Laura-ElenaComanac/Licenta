package com.license.ProjectSocialNetwork.controller.dto;

import com.license.ProjectSocialNetwork.model.User;
import lombok.*;
import org.hibernate.validator.constraints.Length;

import javax.persistence.Column;
import javax.validation.constraints.Size;
import java.time.LocalTime;

@Getter
@Setter
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Data @Builder
public class PostUserDTO extends BaseDTO<Long>{
    private String date;
    @Column(length = 1000)
    private String description;
    private String title;
    private String userid;
}
