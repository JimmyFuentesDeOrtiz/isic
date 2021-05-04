<?php
include('head.php');
$servInfo = getServicio($_GET["idServ"]);
?>
<div class="servicios">
    <section>

        <?php
        echo '<img src="img/servicios/' . $servInfo[0][0] . '.svg?1.0.0">';
        ?>
        <div class="contenedor-texto">

            <?php
            if ($_GET["idServ"] == 4) {
                echo '<h2>' . $servInfo[0][0] . '</h2><p>';
                $tmp = explode("*", $servInfo[0][1]);
                for ($i = 0; $i < sizeof($tmp); $i++) {
                    echo '<small><i class="bi bi-check2"></i> ' . $tmp[$i] . '</small><br>';
                }
                echo '</p>';
            } else {
                echo '<h2>Objetivo de ' . $servInfo[0][0] . '</h2>
                      <p>' . $servInfo[0][1] . ' </p>';
            }
            ?>
        </div>

    </section>
    <?php
    if ($_GET["idServ"] == 2) {
        $Asesoria = getAsesorias();
        $asesor = getAsesor();
        echo '
        <div class="asesorias">
        <section class="site-section">
        <div class="container texto">
            <div class="section-heading text-center">
                <h2><strong>Asesorías</strong></h2>
            </div>
            <div class="row topmargin-xs">';
        $asAux = 0;
        for ($i = 0; $i < sizeof($asesor); $i++) {
            echo ' 
                <div class="col-md-6">
                    <div class="resume-item mb-4">
                        <p>
                        <h3><strong>' . $asesor[$i][0] . '</strong></h3>
                        </p>
                        <table class="table table-light">
                            <tr>
                                <th>Asesorías</th>
                                <th>Día</th>
                                <th>Hora</th>
                            </tr>';
                            for ($j = $asAux; $j < sizeof($Asesoria); $j++) {
                                if ($asesor[$i][0] === $Asesoria[$j][2] ) {
                                    echo ' 
                                    <tr>
                                        <td>' . $Asesoria[$j][4] . '</td>';
                                        switch ($Asesoria[$j][7]) {
                                            case 1:
                                                echo '<td>Lunes</td>';
                                                break;
                                            case 2:
                                                echo '<td>Martes</td>';
                                                break;
                                            case 3:
                                                echo '<td>Miercoles</td>';
                                                break;
                                            case 4:
                                                echo '<td>Jueves</td>';
                                                break;
                                            case 5:
                                                echo '<td>Viernes</td>';
                                                break;
                                        }
                                        echo '
                                        <td>' . $Asesoria[$j][5] . '-' . $Asesoria[$j][6] . '</td>
                                    </tr>';
                                    $asAux++;
                                }
                                else if ($asesor[$i][0] != $Asesoria[$j][2] ){
                                    $j = sizeof($Asesoria);
                                }
                            }
                            echo '
                        </table>
                    </div>
                </div>';
        }
        echo '
            </div>
        </div>
    </section>
</div>
        ';
    }
    ?>
</div>
<?php include('footer.php'); ?>