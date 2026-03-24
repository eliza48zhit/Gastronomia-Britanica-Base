// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title GastronomiaBritanica
 * @dev Registro historico con Likes, Dislikes y Clasificacion de Hora del Te.
 */
contract GastronomiaBritanica {

    struct Plato {
        string nombre;
        string descripcion;
        bool esHoraDelTe; // True si es para el te de las 5, False si es plato fuerte
        uint256 likes;
        uint256 dislikes;
    }

    mapping(uint256 => Plato) public menuHistorico;
    uint256 public totalPlatos;

    constructor() {
        // Inauguramos con Fish and Chips
        registrarPlato("Fish and Chips", "Pescado rebozado frito servido con patatas fritas y pure de guisantes.", false);
    }

    function registrarPlato(string memory _nombre, string memory _descripcion, bool _esHoraDelTe) public {
        string memory validacion = string(abi.encodePacked(_nombre, ": ", _descripcion));
        require(bytes(validacion).length <= 200, "El texto es demasiado largo (max 200 caracteres)");
        
        totalPlatos++;
        menuHistorico[totalPlatos] = Plato({
            nombre: _nombre,
            descripcion: _descripcion,
            esHoraDelTe: _esHoraDelTe,
            likes: 0,
            dislikes: 0
        });
    }

    function darLike(uint256 _id) public {
        require(_id > 0 && _id <= totalPlatos, "El plato no existe.");
        menuHistorico[_id].likes++;
    }

    function darDislike(uint256 _id) public {
        require(_id > 0 && _id <= totalPlatos, "El plato no existe.");
        menuHistorico[_id].dislikes++;
    }

    function consultarPlato(uint256 _id) public view returns (
        string memory nombre, 
        string memory descripcion, 
        bool esHoraDelTe,
        uint256 likes, 
        uint256 dislikes
    ) {
        require(_id > 0 && _id <= totalPlatos, "ID invalido.");
        Plato storage p = menuHistorico[_id];
        return (p.nombre, p.descripcion, p.esHoraDelTe, p.likes, p.dislikes);
    }
}
