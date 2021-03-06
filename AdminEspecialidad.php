<?php
include('./headAdmin.php');
$especialidad = getEspecialidadAdmin();
$egreso = getEgresoAdmin();
$asiEsp = getAsignaturaEspAdmin();
$pagina1 = 'active';
include('AdminSidebar.php');
?>
<div class="admon">
    <div class="container">
        <h2>Especialidades</h2>
        <!--Tabla de especialidad: Sección 1-->
        <div class="tab">
            <button class="tablinks" onclick="openCity(event, 'tab1')" id="defaultOpen"><i class="bi bi-file-check-fill"></i>Existentes</button>
            <button class="tablinks" onclick="openCity(event, 'tab2')"><i class="bi bi-file-earmark-person-fill"></i>Perfil de Egreso</button>
            <button class="tablinks" onclick="openCity(event, 'tab3')"><i class="bi bi-book-fill"></i>Asignaturas</button>

        </div>
        <div id="tab1" class="tabcontent">
            <div id="titulo">
                <h6><b>Especilidades existentes en la malla curricular de la Ingeniería en Sistemas Computacionales</b></h6>
            </div>
            <table class="table table-light table-hover">
                <thead>
                    <tr>
                        <th>Imagen</th>
                        <th>Nombre</th>
                        <th>Reticula</th>
                        <th><button type="button" class="btn btn-light" data-toggle="modal" data-target="#myModal1AddEsp"><i class="bi bi-plus-circle"></i></button>
                            <div class="modal" id="myModal1AddEsp">
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
                                                    <input type="text" class="form-control" id="opEsp" name="opEsp" value="1">
                                                </div>
                                                <div class="form-group" style="display:none">
                                                    <input type="text" class="form-control" id="opGlobal" name="opGlobal" value="1">
                                                </div>
                                                <div class="form-group">
                                                    <label for="nombre" style="color:black;">Nombre:</label>
                                                    <input type="text" class="form-control" id="nombreEspAdd" placeholder="Ingresa el nombre de la especialidad" name="nombreEspAdd" required>
                                                    <div class="valid-feedback">Valido.</div>
                                                    <div class="invalid-feedback">Por favor verifique los campos.</div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="objetivo" style="color:black;">Objetivo:</label>
                                                    <textarea class="form-control" rows="5" id="objetivoEspAdd" placeholder="Ingresa el objetivo de la especialidad" name="objetivoEspAdd" required></textarea>
                                                    <div class="valid-feedback">Valido.</div>
                                                    <div class="invalid-feedback">Por favor verifique los campos.</div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="imagenAdd" style="color:black;">Imagen:</label>
                                                    <input type="file" class="form-control" id="imagenAdd" name="imagenAdd">
                                                </div>
                                                <div class="form-group">
                                                    <label for="pdfReticulaAdd" style="color:black;">PDF Reticula:</label>
                                                    <input type="file" accept="application/pdf" class="form-control" id="pdfReticulaAdd" name="pdfReticulaAdd">
                                                </div>
                                                <button type="submit" class="btn btn-primary">Aceptar</button>
                                                <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <?php
                        for ($i = 0; $i < sizeof($especialidad); $i++) {
                            echo '<tr>
                                    <td><img src="img/especialidades/' . $especialidad[$i][5] . '" width=70px></img></td>
                                    <td>' . $especialidad[$i][1] . '<br>
                                    <a href=# data-toggle="modal" data-target="#myModaObjetivo" onclick="modVerMas(\'' . $especialidad[$i][1] . '\', \'' . $especialidad[$i][2] . '\');">Objetivo</a>
                                        <div class="modal" id="myModaObjetivo">
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
                                    </td>';
                            if ($especialidad[$i][4] != 'Sin Archivo' && strlen($especialidad[$i][4]) > 0) {
                                echo '<td class="text-center">
                                            <a target="_black" href="http://' . $_SERVER['HTTP_HOST'] . '/isic/pdf/malla/' . $especialidad[$i][4] . '">
                                            <i class="bi bi-file-earmark-check"></i></a></td>';
                            } else
                                echo '<td class="text-center"><i class="bi bi-file-earmark-excel"></i></td>';
                            echo '<td> 
                                        <div class="btn-group">
                                            <button class="btn btn-light btn-sm" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                <i class="bi bi-three-dots-vertical"></i>
                                            </button>
                                            <div class="dropdown-menu dropdown-menu-right">
                                            <a class="dropdown-item" data-toggle="modal" data-target="#myModal" onclick="datosModalEsp1(\'' . $especialidad[$i][0] . '\', \'' . $especialidad[$i][1] . '\', \'' . $especialidad[$i][2] . '\', \'' . $especialidad[$i][4] . '\', \'' . $especialidad[$i][5] . '\');"><i class="bi bi-pencil-square"></i>Editar</a>';
                            if ($especialidad[$i][3] === 1) {
                                echo '<a class="dropdown-item" href="Controlador/ControlBorrar.php?id=0*' . $especialidad[$i][0] . '*2*1"><i class = "bi bi-eye-slash"></i>Ocultar</a>';
                            } else {
                                echo '<a class="dropdown-item" href="Controlador/ControlBorrar.php?id=0*' . $especialidad[$i][0] . '*1*1"><i class = "bi bi-eye"></i>Activar</a>';
                            }
                            echo '<a class = "dropdown-item" href = "Controlador/ControlBorrar.php?id=0*' . $especialidad[$i][0] . '*0*2*' . $especialidad[$i][4] . '*' . $especialidad[$i][5] . '"><i class = "bi bi-trash-fill"></i>Eliminar</a>
                              <a class="dropdown-item" data-toggle="modal" data-target="#myModalAdver" onclick="datosModalEsp4(\'' . $especialidad[$i][0] . '\', \'' . $especialidad[$i][1] . '\');"><i class="bi bi-clock-history"></i>Añadir a historial</a>
                                            </div>
                                            </div>
                                            <div class="modal" id="myModalAdver">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <!-- Modal Header-->
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" style="color:darkslategrey;">Advertencia</h5>
                                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                    </div>

                                                    <!-- Modal body -->
                                                    <div class="modal-body">
                                                        <form class="needs-validation" novalidate action="Controlador/ControlEditar.php"  method="POST">
                                                            <div class="form-group" style="display:none">
                                                                <input type="text" class="form-control" id="opGlobal" name="opGlobal" value="6">
                                                            </div>
                                                            <div class="form-group" style="display:none">
                                                                <input type="text" class="form-control" id="idAdverEsp" name="idAdverEsp">
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="nombre" style="color:black;" id="NomAdverEsp" name="NomAdverEsp"></label>
                                                            </div>
                                                            <button type="submit" class="btn btn-primary">Aceptar</button>
                                                            <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal" id="myModal">
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
                                                                <input type="text" class="form-control" id="idespecialidadEsp" name="idespecialidadEsp">
                                                            </div>
                                                            <div class="form-group" style="display:none">
                                                                <input type="text" class="form-control" id="opEsp" name="opEsp" value="1">
                                                            </div>
                                                            <div class="form-group" style="display:none">
                                                                <input type="text" class="form-control" id="opGlobal" name="opGlobal" value="1">
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="nombre" style="color:black;">Nombre:</label>
                                                                <input type="text" class="form-control" id="nombreEsp" placeholder="Ingresa el nombre de la especialidad" name="nombreEsp" required>
                                                                <div class="valid-feedback">Valido.</div>
                                                                <div class="invalid-feedback">Por favor verifique los campos.</div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="objetivo" style="color:black;">Objetivo:</label>
                                                                <textarea class="form-control" rows="5" id="objetivoEsp" placeholder="Ingresa el objetivo de la especialidad" name="objetivoEsp" required></textarea>
                                                                <div class="valid-feedback">Valido.</div>
                                                                <div class="invalid-feedback">Por favor verifique los campos.</div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="imagenAdd" style="color:black;">Imagen:</label>
                                                                <input type="file" class="form-control" id="imagenEsp" name="imagenEsp">
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="pdfReticula" style="color:black;">PDF Reticula:</label>
                                                                <input type="file" accept="application/pdf" class="form-control" id="pdfReticula" name="pdfReticula">
                                                            </div>
                                                            <div class="form-group" style="display:none">
                                                                <input type="text" class="form-control" id="nomOriPdfEsp"  name="nomOriPdfEsp">
                                                            </div>
                                                            <div class="form-group" style="display:none">
                                                                <input type="text" class="form-control" id="nomOriImgEsp"  name="nomOriImgEsp">
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
            <!--Tabla de especialidad: Sección 2-->
            <div id="titulo">
                <h6><b>Perfil de egreso de las distintas especiliadades</b></h6>
            </div>
            <table class="table table-light table-hover">
                <thead>
                    <tr>
                        <th>Especialidad</th>
                        <th>Perfil de Egreso</th>
                        <th><button type="button" class="btn btn-light" data-toggle="modal" data-target="#myModal1AddPerEsp"><i class="bi bi-plus-circle"></i></button></th>
                        <div class="modal topmargin-xs" id="myModal1AddPerEsp">
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
                                            <div class="form-group">
                                                <label for="idegresoEspAdd" style="color:black;">Especialidad:</label>
                                                <select id="idegresoEspAdd" name="idegresoEspAdd" class="custom-select mb-3 form-control" onchange="showSelected();" required>
                                                    <option selected>-Selecciona-</option>
                                                    <?php
                                                    for ($j = 0; $j < sizeof($especialidad); $j++) {
                                                        echo '<option value="' . $especialidad[$j][0] . '">' . $especialidad[$j][1] . '</option>';
                                                    }
                                                    ?>
                                                </select>
                                                <div class="valid-feedback">Valido.</div>
                                                <div class="invalid-feedback">Por favor verifique los campos.</div>
                                            </div>
                                            <div class="form-group">
                                                <label for="perfil" style="color:black;">Perfil de Egreso:</label>
                                                <textarea class="form-control" rows="5" id="perfilEspAdd" placeholder="Ingresa el perfil de egreso" name="perfilEspAdd" required></textarea>
                                                <div class="valid-feedback">Valido.</div>
                                                <div class="invalid-feedback">Por favor verifique los campos.</div>
                                            </div>
                                            <div class="form-group" style="display:none">
                                                <input type="text" class="form-control" id="opEsp" name="opEsp" value="2">
                                            </div>
                                            <div class="form-group" style="display:none">
                                                <input type="text" class="form-control" id="opGlobal" name="opGlobal" value="1">
                                            </div>
                                            <button type="submit" class="btn btn-primary">Aceptar</button>
                                            <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    for ($i = 0; $i < sizeof($egreso); $i++) {
                        echo '<tr>
                                        <td>' . $egreso[$i][1] . '</td>
                                        <td> <a href=# data-toggle="modal" data-target="#myModalEgr" onclick="modVerMasEgr(\'' . $egreso[$i][1] . '\', \'' . $egreso[$i][2] . '\');">Ver mas</a>
                                            <div class="modal topmargin-sm" id="myModalEgr">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">

                                                        <!-- Modal Header-->
                                                        <div class="modal-header">
                                                            <h5 id="ModEspEgr" class="modal-title" style="color:darkslategrey;"></h5>
                                                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                        </div>

                                                        <!-- Modal body -->
                                                        <div class="modal-body">
                                                            <p id="ModEgre"></p>
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
                                                <a class="dropdown-item" data-toggle="modal" data-target="#myModal1" onclick="datosModalEsp2(\'' . $egreso[$i][0] . '\', \'' . $egreso[$i][2] . '\');"><i class="bi bi-pencil-square"></i>Editar</a>';
                        if ($egreso[$i][3] === 1) {
                            echo '<a class="dropdown-item" href="Controlador/ControlBorrar.php?id=1*' . $egreso[$i][0] . '*' . $egreso[$i][2] . '*2*1"><i class = "bi bi-eye-slash"></i>Ocultar</a>';
                        } else {
                            echo '<a class="dropdown-item" href="Controlador/ControlBorrar.php?id=1*' . $egreso[$i][0] . '*' . $egreso[$i][2] . '*1*1"><i class = "bi bi-eye"></i>Activar</a>';
                        }
                        echo '<a class="dropdown-item" href="Controlador/ControlBorrar.php?id=1*' . $egreso[$i][0] . '*' . $egreso[$i][2] . '*0*2"><i class="bi bi-trash-fill"></i>Eliminar</a>
                                            </div>
                                            </div>
                                            <div class="modal topmargin-sm" id="myModal1">
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
                                                                <div class="form-group">
                                                                    <label for="perfil" style="color:black;">Perfil de Egreso:</label>
                                                                    <textarea class="form-control" rows="5" id="perfilEsp" placeholder="Ingresa el perfil de egreso" name="perfilEsp" required></textarea>
                                                                    <div class="valid-feedback">Valido.</div>
                                                                    <div class="invalid-feedback">Por favor verifique los campos.</div>
                                                                </div>
                                                                <div class="form-group" style="display:none">
                                                                    <input type="text" class="form-control" id="idegresoEsp" name="idegresoEsp" required>
                                                                </div>
                                                                <div class="form-group" style="display:none">
                                                                    <input type="text" class="form-control" id="perfilOriEsp" name="perfilOriEsp"required>
                                                                </div>
                                                                <div class="form-group" style="display:none">
                                                                    <input type="text" class="form-control" id="opEsp" name="opEsp" value="2">
                                                                </div>
                                                                <div class="form-group" style="display:none">
                                                                    <input type="text" class="form-control" id="opGlobal" name="opGlobal" value="1">
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
        <div id="tab3" class="tabcontent">
            <!--Tabla de especialidad: Sección 3-->
            <div id="titulo">
                <h6><b>Asignaturas existentes de las distintas especilidades de la Ingeniería en Sistemas Computacionales</b></h6>
            </div>
            <table class="table table-light table-hover">
                <thead>
                    <tr>
                        <th>Especialidad</th>
                        <th>Clave Asignatura</th>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    for ($i = 0; $i < sizeof($asiEsp); $i++) {
                        echo '<tr>
                                        <td>' . $asiEsp[$i][1] . '</td>
                                        <td>' . $asiEsp[$i][2] . '<br>
                                        <a href=# data-toggle="modal" data-target="#myModalDesc" onclick="modVerMasDesc(\'' . $asiEsp[$i][2] . '\', \'' . $asiEsp[$i][3] . '\');">Descripción</a>
                                            <div class="modal topmargin-sm" id="myModalDesc">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">

                                                        <!-- Modal Header-->
                                                        <div class="modal-header">
                                                            <h5 id="ModClav" class="modal-title" style="color:darkslategrey;"></h5>
                                                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                        </div>

                                                        <!-- Modal body -->
                                                        <div class="modal-body">
                                                            <p id="ModDesc"></p>
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
                                                <a class="dropdown-item" data-toggle="modal" data-target="#myModal2" onclick="datosModalEsp3(\'' . $asiEsp[$i][0] . '\', \'' . $asiEsp[$i][2] . '\', \'' . $asiEsp[$i][3] . '\');"><i class="bi bi-pencil-square"></i>Editar</a>';

                        if ($asiEsp[$i][4] === 1) {
                            echo '<a class="dropdown-item" href="Controlador/ControlBorrar.php?id=2*' . $asiEsp[$i][0] . '*' . $asiEsp[$i][2] . '*2*1"><i class = "bi bi-eye-slash"></i>Ocultar</a>';
                        } else {
                            echo '<a class="dropdown-item" href="Controlador/ControlBorrar.php?id=2*' . $asiEsp[$i][0] . '*' . $asiEsp[$i][2] . '*1*1"><i class = "bi bi-eye"></i>Activar</a>';
                        }
                        echo '<a class="dropdown-item" href="Controlador/ControlBorrar.php?id=2*' . $asiEsp[$i][0] . '*' . $asiEsp[$i][2] . '*0*2"><i class="bi bi-trash-fill"></i>Eliminar</a>
                                            </div>
                                            </div>
                                            <div class="modal" id="myModal2">
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
                                                                <div class="form-group" >
                                                                    <label for="descripcion" id="labclaveEsp" name="labclaveEsp" style="color:black;"></label>
                                                                    <input type="text" class="form-control" id="claveEsp" name="claveEsp" style="display:none" required>
                                                                </div>
                                                                <div class="form-group" style="display:none">
                                                                    <input type="text" class="form-control" id="idEspEsp" name="idEspEsp">
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="descripcion" style="color:black;">Descripción:</label>
                                                                    <textarea class="form-control" rows="5" id="descripcionEsp" placeholder="Ingresa la descripción de la asignatura" name="descripcionEsp" required></textarea>
                                                                    <div class="valid-feedback">Valido.</div>
                                                                    <div class="invalid-feedback">Por favor verifique los campos.</div>
                                                                </div>
                                                                <div class="form-group" style="display:none">
                                                                    <input type="text" class="form-control" id="opEsp" name="opEsp" value="3">
                                                                </div>
                                                                <div class="form-group" style="display:none">
                                                                    <input type="text" class="form-control" id="opGlobal" name="opGlobal" value="1">
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
    </div>
    <script type="text/javascript" src="js/tabs.js"></script>
</div>
</div>
</div>
<?php include('AdminFooter.php')?>
<!--JS Local-->
<script type="text/javascript" src="js/editarEspecialidad.js"></script>
<script type="text/javascript" src="js/editarMallaCurricular.js?1.0.0"></script>
<script type="text/javascript" src="js/editarInvestigacion.js?1.0.0"></script>
<script type="text/javascript" src="js/verMas.js?1.0.0"></script>
</body>

</html>