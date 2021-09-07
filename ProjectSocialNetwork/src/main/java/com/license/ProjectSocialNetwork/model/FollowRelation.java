package com.license.ProjectSocialNetwork.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import lombok.*;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.ManyToOne;
import java.time.LocalTime;

@Entity
@Getter
@Setter
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Data @Builder
public class FollowRelation extends BaseEntity<Long> {
    private LocalTime date;
    private Status status;

    @JsonBackReference
    @ManyToOne(fetch = FetchType.LAZY)
    private User activeUser;

    @JsonBackReference
    @ManyToOne(fetch = FetchType.LAZY)
    private User followerUser;
}
