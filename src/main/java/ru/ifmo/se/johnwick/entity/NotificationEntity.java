package ru.ifmo.se.johnwick.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.ZonedDateTime;


@Getter
@Setter
@Entity
@Table(name = "notification")
public class NotificationEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @Column(name = "title", nullable = false)
    private String title;

    @Column(name = "created_timestamp", nullable = false, insertable = false, updatable = false)
    private ZonedDateTime createdTimestamp;

    @ManyToOne
    @JoinColumn(name = "target_id")
    private UserEntity target;
}
