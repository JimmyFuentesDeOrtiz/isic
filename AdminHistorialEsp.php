<?php
include('./headAdmin.php');
$historialInfo = getHistorialInfo();
$contenidoHistorialAdmin = getContenidoHistorialAdmin();
$pagina7 = 'active';
include('AdminSidebar.php');
?>
<div class="admon">
    <div class="container">
        <h2>Historial de Especialidades</h2>
        <!--Tabla de especialidad: Sección 1-->
        <div class="tab">
            <button class="tablinks" onclick="openCity(event, 'tab1')" id="defaultOpen"><i class="bi bi-clock-history"></i>Historial</button>
            <button class="tablinks" onclick="openCity(event, 'tab2')"><i class="bi bi-book-fill"></i>Contenido</button>
        </div>
        <div id="tab1" class="tabcontent">
        <div id="titulo">
            <h6><b>Historial de especialidades de la Ingeniería en Sistemas Computacionales</b><button type="button" class="btn btn-light" data-toggle="modal" data-target="#myModal1AddHist"><i class="bi bi-plus-circle"></i></button></h6>
        </div>
        <table class="table table-light table-hover">
            <thead>
                <tr>
                    <th>Imagen</th>
                    <th>Nombre</th>
                    <th>Objetivo</th>
                    <th>
                        <div class="modal topmargin-xs" id="myModal1AddHist">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <!-- Modal Header-->
                                    <div class="modal-header">
                                        <h5 class="modal-title" style="color:darkslategrey;">Agregar</h5>
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    </div>
                                    <!-- Modal body -->
                                    <div class="modal-body">
                                        <form class="needs-validation" novalidate action="Controlador/ControlAgregar.php" enctype="multipart/form-data" method="POST">
                                            <div class="form-group" style="display:none">
                                                <input type="text" class="form-control" id="opGlobal" name="opGlobal" value="7">
                                            </div>
                                            <div class="form-group" style="display:none">
                                                <input type="text" class="form-control" id="opHist" name="opHist" value="1">
                                            </div>
                                            <div class="form-group">
                                                <label for="nombre" style="color:black;">Nombre:</label>
                                                <input type="text" class="form-control" id="nombreHistAdd" placeholder="Ingrese el nombre" name="nombreHistAdd" required>
                                                <div class="valid-feedback">Valido.</div>
                                                <div class="invalid-feedback">Por favor verifique los campos.</div>
                                            </div>
                                            <div class="form-group">
                                                <label for="objetivo" style="color:black;">Objetivo:</label>
                                                <textarea class="form-control" rows="5" id="objHistAdd" placeholder="Ingresa el objetivo" name="objHistAdd" required></textarea>
                                                <div class="valid-feedback">Valido.</div>
                                                <div class="invalid-feedback">Por favor verifique los campos.</div>
                                            </div>
                                            <div class="form-group">
                                                <label for="imagenAdd" style="color:black;">Imagen:</label>
                                                <input type="file" class="form-control" id="imagenHistAdd" name="imagenHistAdd" required>
                                            </div>
                                            <button type="submit" class="btn btn-primary">Aceptar</button>
                                            <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <?php
                    for ($i = 0; $i < sizeof($historialInfo); $i++) {
                        echo '<tr>
                                <td><img src="img/especialidades/historial/' . $historialInfo[$i][3] . '" width=70px></img></td>
                                <td>' . $historialInfo[$i][1] . '</td>
                                <td> <a href=# data-toggle="modal" data-target="#myModaObjetivo" onclick="modVerMas(\'' . $historialInfo[$i][1] . '\', \'' . $historialInfo[$i][2] . '\');">Ver mas</a>
                                    <div class="modal topmargin-xs" id="myModaObjetivo">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <!-- Modal Header-->
                                                <div class="modal-header">
                                                    <h5 id="ModNom" class="modal-title" style="color:darkslategrey;"></h5>
                                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                </div>

                                                <!-- Modal body -->
                                                <div class="modal-body">
                                                    <p id="ModObj"></p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td> 
                                <div class="btn-group">
                                <button class="btn btn-light btn-sm" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="bi bi-three-dots-vertical"></i>
                                </button>
                                <div class="dropdown-menu dropdown-menu-right">
                                            <a class="dropdown-item" data-toggle="modal" data-target="#myModalHisInfo" onclick="datosModalHistoInfo(\'' . $historialInfo[$i][0] . '\', \'' . $historialInfo[$i][1] . '\', \'' . $historialInfo[$i][2] . '\', \'' . $historialInfo[$i][3] . '\');"><i class="bi bi-pencil-square"></i>Editar</a>';
                        if ($historialInfo[$i][4] == 1) {
                            echo '<a class="dropdown-item" href="Controlador/ControlBorrar.php?id=10*' . $historialInfo[$i][0] . '*2*1"><i class = "bi bi-eye-slash"></i>Ocultar</a>';
                        } else {
                            echo '<a class="dropdown-item" href="Controlador/ControlBorrar.php?id=10*' . $historialInfo[$i][0] . '*1*1"><i class = "bi bi-eye"></i>Activar</a>';
                        }
                        echo '<a class="dropdown-item" href = "Controlador/ControlBorrar.php?id=10*' . $historialInfo[$i][0] . '*0*2*' . $historialInfo[$i][3] . '"><i class = "bi bi-trash-fill"></i>Eliminar</a>
                                            </div>
                                        </div>
                                        </div>
                                        <div class="modal topmargin-xs" id="myModalHisInfo">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <!-- Modal Header-->
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" style="color:darkslategrey;">Editar</h5>
                                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                    </div>

                                                    <!-- Modal body -->
                                                    <div class="modal-body">
                                                        <form class="needs-validation" novalidate action="Controlador/ControlEditar.php" enctype="multipart/form-data" method="POST">
                                                            <div class="form-group" style="display:none">
                                                                <input type="text" class="form-control" id="idHist" name="idHist">
                                                            </div>
                                                            <div class="form-group" style="display:none">
                                                                <input type="text" class="form-control" id="opGlobal" name="opGlobal" value="8">
                                                            </div>
                                                            <div class="form-group" style="display:none">
                                                                <input type="text" class="form-control" id="opHist" name="opHist" value="1">
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="nombre" style="color:black;">Nombre:</label>
                                                                <input type="text" class="form-control" id="nombreHist" placeholder="Nombre de la Complementaria" name="nombreHist" required>
                                                                <div class="valid-feedback">Valido.</div>
                                                                <div class="invalid-feedback">Por favor verifique los campos.</div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="objetivo" style="color:black;">Objetivo:</label>
                                                                <textarea class="form-control" rows="5" id="objHist" placeholder="Ingresa la descripción de la Complementaria" name="objHist" required></textarea>
                                                                <div class="valid-feedback">Valido.</div>
                                                                <div class="invalid-feedback">Por favor verifique los campos.</div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="imagenAdd" style="color:black;">Imagen:</label>
                                                                <input type="file" class="form-control" id="imagenHist" name="imagenHist">
                                                            </div>
                                                            <div class="form-group" style="display:none">
                                                                <input type="text" class="form-control" id="imagenOriHist"  name="imagenOriHist">
                                                            </div>
                                                            <button type="submit" class="btn btn-primary">Aceptar</button>
                                                            <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    </tr>';
                    }
                    ?>
            </tbody>
        </table>
        </div>
        <div id="tab2" class="tabcontent">
        <div id="titulo">
            <h6><b>Contenido de las especialidades en historial</b><button type="button" class="btn btn-light" data-toggle="modal" data-target="#myModal1AddCont"><i class="bi bi-plus-circle"></i>Agregar</button></h6>
        </div>
        <table class="table table-light table-hover">
            <thead>
                <tr>
                    <th>Especialidad</th>
                    <th>Asignatura</th>
                    <th>
                        <div class="modal topmargin-xs" id="myModal1AddCont">
                            <div class="modal-dialog">
                                <div class="modal-content">

                                    <!-- Modal Header-->
                                    <div class="modal-header">
                                        <h5 class="modal-title" style="color:darkslategrey;">Agregar</h5>
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    </div>

                                    <!-- Modal body -->
                                    <div class="modal-body">
                                        <form class="needs-validation" novalidate action="Controlador/ControlAgregar.php" method="POST">

                                            <div class="from-group">
                                                <label for="temaInvAdd" style="color:black;">Especialidad:</label>
                                                <select id="espConteHistoAdd" name="espConteHistoAdd" class="custom-select mb-3 form-control" required>
                                                    <option selected>-Selecciona-</option>';
                                                    <?php
                                                    for ($j = 0; $j < sizeof($historialInfo); $j++) {
                                                        echo '<option value="' . $historialInfo[$j][0] . '">' . $historialInfo[$j][1] . '</option>';
                                                    }
                                                    ?>
                                                </select>
                                                <div class="valid-feedback">Valido.</div>
                                                <div class="invalid-feedback">Por favor verifique los campos.</div>
                                            </div>
                                            <div class="form-group">
                                                <label for="nombre" style="color:black;">Asignatura:</label>
                                                <input type="text" class="form-control" id="nombreContAdd" placeholder="Ingrese el nombre de asignatura" name="nombreContAdd" required>
                                                <div class="valid-feedback">Valido.</div>
                                                <div class="invalid-feedback">Por favor verifique los campos.</div>
                                            </div>
                                            <div class="form-group" style="display:none">
                                                <input type="text" class="form-control" id="opHist" name="opHist" value="2">
                                            </div>
                                            <div class="form-group" style="display:none">
                                                <input type="text" class="form-control" id="opGlobal" name="opGlobal" value="7">
                                            </div>
                                            <button type="submit" class="btn btn-primary">Aceptar</button>
                                            <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </th>
                </tr>
            </thead>
            <tbody>
                <?php
                for ($i = 0; $i < sizeof($contenidoHistorialAdmin); $i++) {
                    echo '<tr>
                            <td>' . $contenidoHistorialAdmin[$i][2] . '</td>
                            <td>' . $contenidoHistorialAdmin[$i][0] . '</td>
                            <td> 
                            <div class="btn-group">
                        <button class="btn btn-light btn-sm" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="bi bi-three-dots-vertical"></i>
                        </button>
                        <div class="dropdown-menu dropdown-menu-right">
                                <a class="dropdown-item" data-toggle="modal" data-target="#myModalCont" onclick="datosModalCont(\'' . $contenidoHistorialAdmin[$i][3] . '\', \'' . $contenidoHistorialAdmin[$i][0] . '\');"><i class="bi bi-pencil-square"></i>Editar</a>';
                    if ($contenidoHistorialAdmin[$i][1] === 1) {
                        echo '<a class="dropdown-item" href="Controlador/ControlBorrar.php?id=11*' . $contenidoHistorialAdmin[$i][3] . '*' . $contenidoHistorialAdmin[$i][0] . '*2*1"><i class = "bi bi-eye-slash"></i>Ocultar</a>';
                    } else {
                        echo '<a class="dropdown-item" href="Controlador/ControlBorrar.php?id=11*' . $contenidoHistorialAdmin[$i][3] . '*' . $contenidoHistorialAdmin[$i][0] . '*1*1"><i class = "bi bi-eye"></i>Activar</a>';
                    }
                    echo '<a class="dropdown-item" href="Controlador/ControlBorrar.php?id=11*' . $contenidoHistorialAdmin[$i][3] . '*' . $contenidoHistorialAdmin[$i][0] . '*0*2"><i class="bi bi-trash-fill"></i>Eliminar</a>
                            </div>
                            </div>
                            <div class="modal topmargin-xs" id="myModalCont">
                                <div class="modal-dialog">
                                    <div class="modal-content">

                                        <!-- Modal Header-->
                                        <div class="modal-header">
                                            <h5 class="modal-title" style="color:darkslategrey;">Editar</h5>
                                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                                        </div>

                                        <!-- Modal body -->
                                        <div class="modal-body">
                                            <form class="needs-validation" novalidate action="Controlador/ControlEditar.php" method="POST">

                                                <div class="from-group">
                                                    <label for="espConteHisto" style="color:black;">Especialidad:</label>
                                                    <select id="espConteHisto" name="espConteHisto" class="custom-select mb-3 form-control" required>';
                                                for ($j = 0; $j < sizeof($historialInfo); $j++) {
                                                    echo '<option value="' . $historialInfo[$j][0] . '">' . $historialInfo[$j][1] . '</option>';
                                                }
                                                echo '</select>
                                                    <div class="valid-feedback">Valido.</div>
                                                    <div class="invalid-feedback">Por favor verifique los campos.</div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="nombreCont" style="color:black;">Asignatura:</label>
                                                    <input type="text" class="form-control" id="nombreCont" placeholder="Ingrese el nombre de asignatura" name="nombreCont" required>
                                                    <div class="valid-feedback">Valido.</div>
                                                    <div class="invalid-feedback">Por favor verifique los campos.</div>
                                                </div>
                                                <div class="form-group" style="display:none">
                                                    <input type="text" class="form-control" id="opHist" name="opHist" value="2">
                                                </div>
                                                <div class="form-group" style="display:none">
                                                    <input type="text" class="form-control" id="opGlobal" name="opGlobal" value="8">
                                                </div>
                                                <div class="form-group" style="display:none">
                                                    <input type="text" class="form-control" id="nombreOriCont" name="nombreOriCont">
                                                </div>
                                                <div class="form-group" style="display:none">
                                                    <input type="text" class="form-control" id="espOriCont" name="espOriCont">
                                                </div>
                                                <button type="submit" class="btn btn-primary">Aceptar</button>
                                                <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </td>
                        </tr>';
                }
                ?>
            </tbody>
        </table>
        </div>
        <script type="text/javascript" src="js/tabs.js"></script>
    </div>
</div>
</div>
</div>
<?php include('AdminFooter.php')?>
<!--JS Local-->
<script type="text/javascript" src="js/editarHistorial.js?1.0.0"></script>
<script type="text/javascript" src="js/verMas.js?1.0.0"></script>
</body>

</html>