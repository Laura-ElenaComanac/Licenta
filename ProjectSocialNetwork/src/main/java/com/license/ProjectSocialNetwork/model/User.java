package com.license.ProjectSocialNetwork.model;


import lombok.*;

import javax.persistence.Entity;

@Entity
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Data @Builder
public class User extends BaseEntity<Long> {
    private String username;
    private String password;
    private String name;
    private String type;
    private String email;
    private String location;

}
