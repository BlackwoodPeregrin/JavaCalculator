package app;

import org.springframework.data.jpa.repository.JpaRepository;

public interface Repository extends JpaRepository<HistoryCalculation, Long> {
}
