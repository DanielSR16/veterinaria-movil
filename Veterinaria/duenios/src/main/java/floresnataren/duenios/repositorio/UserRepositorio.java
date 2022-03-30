package floresnataren.duenios.repositorio;

import floresnataren.duenios.modelo.Duenio;
import floresnataren.duenios.modelo.User;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface UserRepositorio extends CrudRepository<User, Integer>{
    User findByUsernameAndPassword(String username, String password);
    User save(User user);
    User findById(int id);
    List<User> findAll();
    void delete(User usuario);
}

