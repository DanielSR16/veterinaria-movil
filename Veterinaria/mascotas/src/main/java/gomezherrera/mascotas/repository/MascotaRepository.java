package gomezherrera.mascotas.repository;


import gomezherrera.mascotas.model.MascotaU;
import org.springframework.data.repository.CrudRepository;


import java.util.List;

public interface MascotaRepository extends CrudRepository<MascotaU, Integer> {
    List<MascotaU> findAll();

//    List<MascotaU> findByIdDuenio(int idDuenio);
//    List<MascotaU> findByIdMedicamento(int idMedicamento);
//    List<MascotaU> findByTipo(String tipo);
//    MascotaU findByIdCita(int idCita);
//
//    List<MascotaU>findAllByNombre(String nombre);

    void delete(MascotaU mascota);

    MascotaU findByIdMascota(int idMascota);
    MascotaU save(MascotaU mascotau);

}