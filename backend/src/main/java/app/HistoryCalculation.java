package app;

import javax.persistence.*;

@Entity
@Table(name = "history_calculation")
public class HistoryCalculation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "expression")
    private String expression;

    @Column(name = "result")
    private String result;
}
