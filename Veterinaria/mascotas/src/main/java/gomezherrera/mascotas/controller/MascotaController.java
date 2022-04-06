package gomezherrera.mascotas.controller;

import gomezherrera.mascotas.model.Duenio;
import gomezherrera.mascotas.model.MascotaDuenio;
import gomezherrera.mascotas.model.MascotaU;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import gomezherrera.mascotas.model.Mascota;
import gomezherrera.mascotas.repository.MascotaRepository;
import org.springframework.web.client.RestTemplate;

import java.util.List;

@RestController
@CrossOrigin(origins = "http://localhost:3000")
public class MascotaController {

    @Autowired
    MascotaRepository mascotaRepository;

    @Autowired
    RestTemplate restTemplate;


    @GetMapping(value = "/listMascotas")
    public List<MascotaU> getListMascota(){
        return mascotaRepository.findAll();
    }



    @PostMapping(value = "/mascota/add")
    public void addMascota(@RequestBody MascotaU mascota){
        mascotaRepository.save(mascota);
    }




    @PostMapping(value = "/mascota/update")
    public MascotaU updateMascota(@RequestBody MascotaU mascota){
        if(mascotaRepository.findByIdMascota(mascota.getIdMascota())!=null){
            return mascotaRepository.save(mascota);
        }
        return null;
    }



    @PostMapping(value = "/mascota/delete")
        public Boolean deleteMascota(@RequestBody MascotaU mascota) {
            MascotaU m = mascotaRepository.findByIdMascota(mascota.getIdMascota());
            if (m != null) {
                mascotaRepository.delete(m);
                return true;
            }
            return null;
        }

    @GetMapping(value = "/mascota/{idDuenio}")
    public List<MascotaU> getMascotaByIdDuenio(@PathVariable("idDuenio") int idDuenio){
        return mascotaRepository.findByIdDuenio(idDuenio);
    }


}