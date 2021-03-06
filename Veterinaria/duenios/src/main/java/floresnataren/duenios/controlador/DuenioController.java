package floresnataren.duenios.controlador;

import floresnataren.duenios.modelo.*;
import floresnataren.duenios.repositorio.UserRepositorio;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.web.bind.annotation.*;
import floresnataren.duenios.repositorio.DuenioRepository;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@CrossOrigin(origins = "http://localhost:3000/")
public class DuenioController {
    @Autowired
    DuenioRepository duenioRepository;

    @Autowired
    UserRepositorio userRepositorio;

    @Autowired
    RestTemplate restTemplate;

//    @GetMapping(value = "/listDuenios")
//    public List<Duenio> getListduenio(){
//        return duenioRepository.findAll();
//    }

    @GetMapping(value = "/duenioConMascotas/{idDuenio}")
    public DuenioMascota getDuenioConMascotas(@PathVariable("idDuenio") int idDuenio){
        Duenio duenio =  duenioRepository.findById(idDuenio);
        DuenioMascota duenioMascota= null;
        if (duenio != null){
            duenioMascota = new DuenioMascota(duenio.getIdDuenio(), duenio.getNombre(), duenio.getTelefono(), duenio.getDireccion());
            Mascota[] mascotas  =restTemplate.getForObject("http://localhost:9998/listByIdDuenio/"+duenioMascota.getIdDuenio(), Mascota[].class);
            duenioMascota.setMascotas(mascotas);
        }
        return duenioMascota;
    }
    @GetMapping(value = "/duenio/direccion")
    public List<Duenio> getDuenioByDireccion(@RequestBody Duenio duenio){
        return duenioRepository.findDuenioByDireccion(duenio.getDireccion());
    }


    @PostMapping(value = "/duenio/telefono")
    public List<Duenio> getDuenioByCountry(@RequestBody Duenio duenio){
        return duenioRepository.findAllByTelefono(duenio.getTelefono());
    }
    @PostMapping(value = "/duenio/add")
    public Duenio addDuenio(@RequestBody Duenio duenio){
        return duenioRepository.save(duenio);
    }

    @PostMapping(value = "/duenio/update")
    public Duenio updateDuenio(@RequestBody Duenio duenio){
        if(duenioRepository.findById(duenio.getIdDuenio()) != null){
            return duenioRepository.save(duenio);
        }
        return null;
    }

    @PostMapping(value = "/duenio/delete")
    public Boolean deleteDuenio(@RequestBody Duenio duenio){
        Duenio d = duenioRepository.findById(duenio.getIdDuenio());
        if(d != null){
            duenioRepository.delete(d);
            return true;
        }
        return null;
    }

    private String getJWTToken(String username) {
        String secretKey = "secreto";
        List<GrantedAuthority> grantedAuthorities = AuthorityUtils
                .commaSeparatedStringToAuthorityList("ROLE_USER");

        String token = Jwts
                .builder()
                .setId("userJWT")
                .setSubject(username)
                .claim("authorities",
                        grantedAuthorities.stream()
                                .map(GrantedAuthority::getAuthority)
                                .collect(Collectors.toList()))
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis() + 6000000))
                .signWith(SignatureAlgorithm.HS512,
                        secretKey.getBytes()).compact();

        return "Bearer " + token;
    }

    @PostMapping(value = "/user/login")
    public List login(@RequestBody UsuarioCredentials credentials){
        List data = new ArrayList();
        User usuario = userRepositorio.findByUsernameAndPassword(credentials.getUsername(), credentials.getPassword());
//        System.out.println(usuario);
        if (usuario != null) {
            data.add(usuario.getId());
            data.add(getJWTToken(usuario.getUsername()));
           return data;
        }else
            return null;

    }

    @PostMapping(value = "/user/registro")
    public boolean register(@RequestBody User usuario){
        User user = userRepositorio.save(usuario);

        if(user != null){
            return true;
        }else {
            return false;
        }


    }

    @GetMapping(value = "/user/listUser")
    public List<User> getListduenio(){
        
        return  userRepositorio.findAll();
    }


    @PostMapping(value = "/user/update")
    public User updateUser(@RequestBody User usuario){
        if(userRepositorio.findById(usuario.getId()) != null){
            return userRepositorio.save(usuario);
        }
        return usuario;
    }


    @PostMapping(value = "/user/delete")
    public Boolean deleteUser(@RequestBody User usuario){
        User d = userRepositorio.findById(usuario.getId());
        if(d != null){
            userRepositorio.delete(d);
            return true;
        }
        return null;
    }

    @GetMapping(value="/user/{id}")
    public User getDuenio(@PathVariable("id") int id){
        return userRepositorio.findById(id);
    }
}
