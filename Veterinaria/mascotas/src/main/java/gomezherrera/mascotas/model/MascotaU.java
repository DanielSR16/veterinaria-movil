package gomezherrera.mascotas.model;
import javax.persistence.*;

@Entity
public class MascotaU {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idMascota;

    @Column(name = "idDuenio")
    private int idDuenio;


    @Column(name = "nombre")
    private String nombre;

    @Column(name = "raza")
    private String raza;


    @Column(name = "fechaIngreso")
    private String fechaIngreso;

    @Column(name = "razon")
    private String razon;

    public MascotaU(){

    }

    public MascotaU(int idMascota, String nombre, String raza, int idDuenio, String fechaIngreso, String razon) {
        this.idMascota = idMascota;
        this.nombre = nombre;
        this.raza = raza;
        this.idDuenio = idDuenio;
        this.fechaIngreso = fechaIngreso;
        this.razon = razon;
    }

    public int getIdMascota() {
        return idMascota;
    }

    public void setIdMascota(int idMascota) {
        this.idMascota = idMascota;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getRaza() {
        return raza;
    }

    public void setRaza(String raza) {
        this.raza = raza;
    }

    public int getIdDuenio() {
        return idDuenio;
    }

    public void setIdDuenio(int idDuenio) {
        this.idDuenio = idDuenio;
    }

    public String getFechaIngreso() {
        return fechaIngreso;
    }

    public void setFechaIngreso(String fechaIngreso) {
        this.fechaIngreso = fechaIngreso;
    }

    public String getRazon() {
        return razon;
    }

    public void setRazon(String razon) {
        this.razon = razon;
    }
}
