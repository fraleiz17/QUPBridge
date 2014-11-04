<link type="text/css" rel="stylesheet" href="<?php echo base_url()?>css/index_.css" media="screen"></link>
<?php $this->load->view('general/general_header_view', array('title'=> 'Tienda', 'links' => array('venta', 'tienda'),'scripts'=> array('funciones_venta', 'funciones_tienda', 'funciones_'))) ?>
        <script>
            jQuery(document).ready(function() {


                $(".detalleProducto").click(function() {
                    var productoID = $(this).attr('id');
                    $('#productoDetallePop').load('<?php echo base_url() ?>principal/getDetalleProducto/' + productoID, function() {
                        $('.productoForm').validationEngine();
                        //
                        $(document).scrollTop(0);
                        $('.productoForm').submit(function(e) {
                            e.preventDefault();
                            var form = $(this);
                            if ($('.productoForm').validationEngine('validate')) {                           
                                $.ajax({
                                    url: '<?= base_url() ?>carrito/addProducto_tienda',
                                    data: form.serialize(),
                                    dataType: 'html',
                                    type: 'post',
                                    beforeSend: function() {
                                        $('.loader').append('<div class="spinner"><div class="bounce1"></div><div class="bounce2"></div><div class="bounce3"></div></div>');
                                        //show loader
                                    },
                                    success: function(data) {
                                        $('.infouser', form).empty().html(data);
                                    },
                                    error: function(data) {
                                        $('.infouser', form).empty();
                                        $("<div class='alert alert-warning'>No se ha agregado el producto al carrito. Vuelva a intentarlo o contacte al administrador del sitio.</div>").appendTo($('.infouser', form));
                                    },
                                    complete: function() {
                                        $('.spinner', form).remove();
                                    }
                                });
                            }
                        });
                        //

                    });
                });
            });

        </script>
        <div id="productoDetallePop">
        </div>

        <div id="iconos_ocultos" class="iconos_ocultos">
            <ul class="iconos_estatus">
        <li   <?php if ($this->session->userdata('idUsuario') !== FALSE): ?>  onclick="window.location='<?= base_url() ?>carrito';" <?php else: ?>  <?php endif; ?>>

            <img id="horizontal_compras_mini"
                 onmouseover="mostrar_icono('horizontal_compras'); ocultar_icono('horizontal_compras_mini');"
                 class="iconos_flotantes" src="<?php echo base_url() ?>images/compras_horizontal_mini.png"/>

            <img class="iconos_flotantes2"
                 onmouseout="mostrar_icono('horizontal_compras_mini'); ocultar_icono('horizontal_compras');"
                 id="horizontal_compras" src="<?php echo base_url() ?>images/compras_horizontal.png"
               />

        </li>
        <li <?php if ($this->session->userdata('idUsuario') !== FALSE): ?>
       <?php else: ?> onclick="muestra('contenedor_login');oculta('envio_con');muestra('ingreso_normal');" <?php endif; ?>>
            <img id="horizontal_ingresar_mini"
                 onmouseover="mostrar_icono('horizontal_ingresar'); ocultar_icono('horizontal_ingresar_mini');"
                 class="iconos_flotantes" src="<?php echo base_url() ?>images/ingresar_horizontal_mini.png"/>

            <img class="iconos_flotantes2"
                 onmouseout="mostrar_icono('horizontal_ingresar_mini'); ocultar_icono('horizontal_ingresar');"
                id="horizontal_ingresar"
                 src="<?php echo base_url() ?>images/ingresar_horizontal.png"/>
        </li>

        <li  <?php if ($this->session->userdata('idUsuario') !== FALSE): ?>  <?php else: ?>onclick="muestra('contenedor_registro');" <?php endif; ?>>
            <img id="horizontal_registrate_mini"
                 onmouseover="mostrar_icono('horizontal_registrate'); ocultar_icono('horizontal_registrate_mini');"
                 class="iconos_flotantes" src="<?php echo base_url() ?>images/registrate_horizontal_mini.png"/>

            <img class="iconos_flotantes2"
                 onmouseout="mostrar_icono('horizontal_registrate_mini'); ocultar_icono('horizontal_registrate');"
                 id="horizontal_registrate" src="<?php echo base_url() ?>images/registrate_horizontal.png"/>
        </li>
    </ul>
        </div>
        <?php $this->load->view('general/menu_view'); ?>

        <div class="contenedor_contactar_previo" id="contenedor_contactar_previo" style=" display:none;">
            <div class="contenedor_cerrar_contactar">
                <img src="<?php echo base_url() ?>images/cerrar_anuncio.png" onclick="oculta('contenedor_contactar_previo');"/>
            </div>
            <div class="contactar_al_aunuciante">
                <font class="titulo_anuncio_publicado"> CONTACTA AL ANUNCIANTE </font>
                <br/>
                <br/>
                <strong> Nombre de usuario:</strong> Juanito Perez
                <br/>
                <strong> Estado: </strong> Hidalgo
                <br/>
                <strong> Ciudad: </strong> Actopan
                <br/>
                <strong> Teléfono: </strong> 372829102374746
                <br/>
                <br/>
                <font class="titulo_anuncio_publicado"> PROPORCIONA TU INFORMACIÓN </font>
                <br/>
                <br/>
                <input type="text" class="formu_contacto" id="nombre_contacto"
                       onfocus="clear_textbox('nombre_contacto', 'Nombre');" value="Nombre" size="44"/>
                <input type="text" class="formu_contacto" id="mail_contacto" onfocus="clear_textbox('mail_contacto', 'Tu-email')"
                       value="Tu-email" size="44"/>
                <input type="text" class="formu_contacto" id="asunto_contacto"
                       onfocus="clear_textbox('asunto_contacto', 'Asunto')" value="Asunto" size="44"/>
                <textarea cols="50" onfocus="clear_textbox('comentarios_contacto', 'Comentarios')" id="comentarios_contacto"
                          class="formu_contacto" rows="5">Comentarios</textarea>
                <br/>
                <br/>
                <ul class="boton_naranja_tres">
                    <li>
                        Enviar
                    </li>
                </ul>


            </div>
        </div>


        <div id="contenedor_publicar_anuncio" class="contenedor_publicar_anuncio" style=" display:none;">

            <!-- Inicio contenedor pap publicar anuncio aunucio !-->
            <div id="publicar_anuncio" class="pubicar_anuncio">


                <!-- Inicio Paso UNO -->
                <div id="paso_uno">
                    <div class="numeros_publicar_anuncio">
                        <ul class="listado_numeros_anuncio">
                            <li class="numero_seccion">1</li>
                            <li>2</li>
                            <li>3</li>
                            <li>4</li>
                            <li>5</li>
                        </ul>
                    </div>
                    <div class="crerar_publicar_anuncio">
                        <img src="<?php echo base_url() ?>images/cerrar.png" onclick="oculta('contenedor_publicar_anuncio');"/>

                    </div>
                    <br/>

                    <div class="descipcion_pasos">
                        <div class="titulo_de_pasos"> PUBLICAR ANUNCIO</div>
                        <div class="instrucciones_pasos"> Selecciona la sección de publicación</div>
                        <div class="contenido_indicacion">
                            <img src="<?php echo base_url() ?>images/pero_paso_uno.png" class="perro_paso_uno"/>

                            <form id="form1" name="form1" method="post" class="radios_secciones" action="">
                                <input type="radio" name="radiog_dark" id="radio4" class="css-checkbox"/><label for="radio4"
                                                                                                                class="css-label radGroup2">
                                    Cruza</label>
                                <br/>
                                <input type="radio" name="radiog_dark" id="radio5" class="css-checkbox" checked="checked"/>
                                <label for="radio5" class="css-label radGroup2">Venta</label>
                                <br/>
                                <input type="radio" name="radiog_dark" id="radio6" class="css-checkbox"/><label for="radio6"
                                                                                                                class="css-label radGroup2">Adopción</label>
                                <br/>
                                <input type="radio" name="radiog_dark" id="radio7" class="css-checkbox"/><label for="radio7"
                                                                                                                class="css-label radGroup2">Perros
                                    perdidos</label>
                            </form>

                            <br/>
                            <ul class="morado">
                                <li onclick="muestra('paso_dos');
                                        oculta('paso_uno');">

                                    Continuar
                                </li>
                            </ul>


                        </div>

                    </div>

                </div>
                <!-- FIN anuncio UNO -->


                <!-- Inicio paso DOS -->
                <div id="paso_dos" style="display:none;">
                    <div class="numeros_publicar_anuncio">
                        <ul class="listado_numeros_anuncio">
                            <li>1</li>
                            <li class="numero_seccion">2</li>
                            <li>3</li>
                            <li>4</li>
                            <li>5</li>
                        </ul>
                    </div>
                    <div class="crerar_publicar_anuncio">
                        <img src="<?php echo base_url() ?>images/cerrar.png" onclick="oculta('contenedor_publicar_anuncio');"/>

                    </div>
                    <br/>

                    <div class="descipcion_pasos">
                        <div class="titulo_de_pasos"> PUBLICAR ANUNCIO</div>
                        <div class="instrucciones_pasos"> Indica tu tipo de anuncio</div>
                        <div class="contenido_indicacion">
                            <div id="contenedor_paquetes" class="contenedor_paquetes">


                                <div class="paquetes_izquierda">
                                    <label>
                                        <div class="title_paquetes">
                                            <div class="lateral_lite"></div>
                                            <img src="<?php echo base_url() ?>images/perrito_lite.png" class="margen" width="29"
                                                 height="29"/> <font class="title_paquetes_titilos"> PAQUETE LITE </font>
                                        </div>
                                        <div class="precio_paquete_lite">
                                            <div class="el_titulo_paquete_lite"> Gratis</div>
                                            <div class="descripcion_precio_paquete_lite">al crear tu usuario</div>
                                        </div>
                                        <div class="descripcion_paquetes">
                                            <strong>Incluye:</strong>
                                            <ul class="contenido_paquetes">
                                                <li>
                                                    * 1 fotos
                                                </li>

                                                <li>
                                                    * Texto de 50 caracteres
                                                </li>
                                                <li>
                                                    * Vigencia de 30 días.
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="iconos_paquetes">
                                            <ul>
                                                <li>
                                                    <div class="cantidades_detalle_paquete_lite"> 10</div>
                                                    <img src="<?php echo base_url() ?>images/icono_camara.png" width="34" height="26"/>
                                                </li>
                                                <li>
                                                    <div class="cantidades_detalle_paquete_lite"> 10</div>
                                                    <img src="<?php echo base_url() ?>images/icono_texto.png" width="34" height="26"/>
                                                </li>
                                                <li>
                                                    <div class="cantidades_detalle_paquete_lite"> 10</div>
                                                    <img src="<?php echo base_url() ?>images/icono_calendario.png" width="34" height="26"/>
                                                </li>
                                                <li>
                                                    <div class="cantidades_detalle_paquete_of"> 0</div>
                                                    <img src="<?php echo base_url() ?>images/icono_ticket_of.png" width="34" height="26"/>
                                                </li>
                                                <li>
                                                    <div class="cantidades_detalle_paquete_of"> 0</div>
                                                    <img src="<?php echo base_url() ?>images/icono_video_of.png" width="34" height="26"/>
                                                </li>
                                            </ul>
                                        </div>

                                        <input type="radio" style="margin-left:100px;" name="RadioGroup1" value="radio" id="RadioGroup1_0"/>
                                    </label>

                                </div>


                                <div class="paquetes">
                                    <label>
                                        <div class="title_paquetes">
                                            <div class="lateral_regular"></div>
                                            <img src="<?php echo base_url() ?>images/perrito_regular.png" class="margen" width="29"
                                                 height="29"/> <font class="title_paquetes_titilos"> PAQUETE REGULAR </font>

                                        </div>
                                        <div class="precio_paquete_regular"> $89.00</div>

                                        <div class="descripcion_paquetes">
                                            <strong>Incluye:</strong>
                                            <ul class="contenido_paquetes">
                                                <li>
                                                    * 5 fotos
                                                </li>
                                                <li>
                                                    * Texto de 150 caracteres
                                                </li>
                                                <li>
                                                    * 1 video
                                                </li>
                                                <li>
                                                    * 2 cupones
                                                </li>
                                                <li>
                                                    * Vigencia de 30 días
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="iconos_paquetes">
                                            <ul>
                                                <li>
                                                    <div class="cantidades_detalle_paquete_regular"> 5</div>
                                                    <img src="<?php echo base_url() ?>images/icono_camara_regular.png" width="34"
                                                         height="26"/>
                                                </li>
                                                <li>
                                                    <div class="cantidades_detalle_paquete_regular"> 150</div>
                                                    <img src="<?php echo base_url() ?>images/icono_texto_regular.png" width="34"
                                                         height="26">
                                                </li>
                                                <li>
                                                    <div class="cantidades_detalle_paquete_regular"> 30</div>
                                                    <img src="<?php echo base_url() ?>images/icono_calendario_regular.png" width="34"
                                                         height="26"/>
                                                </li>
                                                <li>
                                                    <div class="cantidades_detalle_paquete_regular"> 2</div>
                                                    <img src="<?php echo base_url() ?>images/icono_ticket_regular.png" width="34"
                                                         height="26"/>
                                                </li>
                                                <li>
                                                    <div class="cantidades_detalle_paquete_regular"> 1</div>
                                                    <img src="<?php echo base_url() ?>images/icono_video_regular.png" width="34"
                                                         height="26"/>
                                                </li>
                                            </ul>
                                        </div>
                                        <input type="radio" style="margin-left:100px;" name="RadioGroup1" value="radio" id="RadioGroup1_1"/>
                                    </label>
                                </div>


                                <div class="paquetes_derecha">
                                    <label>
                                        <div class="title_paquetes">
                                            <div class="lateral_premium"></div>
                                            <img src="<?php echo base_url() ?>images/perrito_premium.png" class="margen" width="29"
                                                 height="29"/> <font class="title_paquetes_titilos"> PAQUETE PREMIUM </font>

                                        </div>
                                        <div class="precio_paquete_premium"> $165.00</div>

                                        <div class="descripcion_paquetes">
                                            <strong>Incluye:</strong>
                                            <ul class="contenido_paquetes">
                                                <li>
                                                    * 15 fotos
                                                </li>
                                                <li>
                                                    * Caracteres ilimitados
                                                </li>
                                                <li>
                                                    * 2 video
                                                </li>
                                                <li>
                                                    * 5 cupones
                                                </li>
                                                <li>
                                                    * Vigencia de 60 días
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="iconos_paquetes">
                                            <ul>
                                                <li>
                                                    <div class="cantidades_detalle_paquete_premium"> 15</div>
                                                    <img src="<?php echo base_url() ?>images/icono_camara_premium.png" width="34"
                                                         height="26"/>
                                                </li>
                                                <li>
                                                    <div class="cantidades_detalle_paquete_premium"> ∞</div>
                                                    <img src="<?php echo base_url() ?>images/icono_texto_premium.png" width="34"
                                                         height="26">
                                                </li>
                                                <li>
                                                    <div class="cantidades_detalle_paquete_premium"> 60</div>
                                                    <img src="<?php echo base_url() ?>images/icono_calendario_premium.png" width="34"
                                                         height="26"/>
                                                </li>
                                                <li>
                                                    <div class="cantidades_detalle_paquete_premium"> 5</div>
                                                    <img src="<?php echo base_url() ?>images/icono_ticket_premium.png" width="34"
                                                         height="26"/>
                                                </li>
                                                <li>
                                                    <div class="cantidades_detalle_paquete_premium"> 2</div>
                                                    <img src="<?php echo base_url() ?>images/icono_video_premium.png" width="34"
                                                         height="26"/>
                                                </li>
                                            </ul>
                                        </div>
                                        <input type="radio" style="margin-left:100px;" name="RadioGroup1" value="radio" id="RadioGroup1_2"/>
                                    </label>
                                </div>


                            </div>
                            <!-- Contenedor de paquetes  -->

                            <br/>
                            <ul class="morado">
                                <li onclick="muestra('paso_tres');
                                        oculta('paso_dos');">Continuar
                                </li>
                            </ul>


                        </div>


                    </div>

                </div>

                <!-- FIN paso dos !-->

                <!-- INICIO paso TRES -->
                <div id="paso_tres" style="display:none;">
                    <div class="numeros_publicar_anuncio">
                        <ul class="listado_numeros_anuncio">
                            <li>1</li>
                            <li>2</li>
                            <li class="numero_seccion">3</li>
                            <li>4</li>
                            <li>5</li>
                        </ul>
                    </div>

                    <div class="crerar_publicar_anuncio">
                        <img src="<?php echo base_url() ?>images/cerrar.png" onclick="oculta('contenedor_publicar_anuncio');"/>

                    </div>
                    <br/>

                    <div class="descipcion_pasos_largo">
                        <div class="titulo_de_pasos"> PUBLICAR ANUNCIO</div>
                        <div class="instrucciones_pasos"> Completa tu información</div>
                        <div class="sub_instrucciones_pasos"> Datos de contacto</div>
                        <div class="contenido_indicacion_formulario">
                            <p class="margen_15_left">Nombre: <input type="text" class="background_morado_35" readonly="readonly"/>
                                Apellido: <input type="text" class="background_morado_35" readonly="readonly"/> Correo electrónico:
                                <input type="text" class="background_morado" readonly="readonly"/></p>
                            <br/>

                            <p class="margen_15_left"> Teléfono: <input type="text" class="background_gris_35"/> Mostrar teléfono en el
                                anuncio: <select class="background_gris_35">
                                    <option>--</option>
                                    <option> Si</option>
                                    <option> No</option>
                                </select>
                            </p>
                            <br/>

                            <div class="sub_instrucciones_pasos"> Detalles del aunucio</div>
                            <br/>

                            <p class="margen_15_left">Sección: <input type="text" class="background_morado_55" readonly="readonly"/>
                                Paquete: <input type="text" class="background_morado_55" readonly="readonly"/> Vencimiento: <input
                                    type="text" class="background_morado" readonly="readonly"/></p>
                            <br/>

                            <p class="margen_15_left"> Titúlo: &nbsp;&nbsp;&nbsp; <input type="text" class="background_gris_55"/> Estado
                                &nbsp;&nbsp;&nbsp;&nbsp;<select class="background_gris_100">
                                    <option>--</option>
                                    <option> Chihuahua</option>
                                    <option> Quintana Roo</option>
                                </select>

                                Ciudad: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input class="background_gris" type="text"/>
                            </p>
                            <br/>

                            <p class="margen_15_left"> Genéro: <select type="text" class="background_gris_100"/>
                                <option> ---</option>
                                <option> Hembra</option>
                                <option> Macho</option>

                                </select>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                Raza &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<select class="background_gris_100">
                                    <option>--</option>
                                    <option> Labrador</option>
                                    <option> Labrador</option>
                                </select>

                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Precio: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <input class="background_gris" type="text"/>
                            </p>
                            <br/>

                            <p class="margen_15_left">
                                Descripción:<textarea class="background_gris" cols="95" rows="3"> </textarea>
                            </p>
                            <br/>

                            <p class="margen_15_left">
                                Link de video <input type="text" size="98"/><img src="<?php echo base_url() ?>images/logo_youtube.png"/>
                            </p>

                            <p class="margen_15_left"><a href="<?php echo base_url() ?>#"> Tutorial para subir video a <img
                                        src="<?php echo base_url() ?>images/logo_youtube.png" width="43" height="16"/> </a></p>
                            <br/>

                            <p class="margen_15_left">

                        <!-- <iframe src="<?php echo base_url() ?>../subir_archivos/index.html" style="overflow:none;" scrolling="no" width="800" height="100"> </iframe> -->
                            </p>

                            <div style="width:800px; height:150px;">

                                TEXTO
                            </div>

                            <ul class="morado_15" style="margin-left:-15px;">

                                <li onclick="muestra('paso_cuatro');
                                        oculta('paso_tres');">

                                    Continuar

                                </li>

                            </ul>

                        </div>
                    </div>
                </div>
                <!-- FIN paso TRES -->

                <div id="paso_cuatro" style="display:none;"> <!-- inicio del contendor paso 4 -->

                    <div class="numeros_publicar_anuncio">
                        <ul class="listado_numeros_anuncio">
                            <li>1</li>
                            <li>2</li>
                            <li>3</li>
                            <li class="numero_seccion">4</li>
                            <li>5</li>
                        </ul>
                    </div>

                    <div class="crerar_publicar_anuncio">
                        <img src="<?php echo base_url() ?>images/cerrar.png" onclick="oculta('contenedor_publicar_anuncio');"/>

                    </div>
                    <br/>

                    <div class="descipcion_pasos_largo">
                        <div class="titulo_de_pasos"> PUBLICAR ANUNCIO</div>
                        <div class="instrucciones_pasos"> Vista previa de tu anuncio</div>
                        <div class="leer_anuncio">


                            <div class="contenedor_galeria">
                                <div id="slideshow_publicar_anuncio" class="picse">
                                    <img src="<?php echo base_url() ?>images/anuncios/02/1.png" width="294" height="200"/>
                                    <img src="<?php echo base_url() ?>images/anuncios/02/2.png" width="294" height="200"/>
                                    <img src="<?php echo base_url() ?>images/anuncios/02/3.png" width="294" height="200"/>
                                    <img src="<?php echo base_url() ?>images/anuncios/02/1.png" width="294" height="200"/>
                                </div>

                            </div>
                            <div class="datos_general">

                                <div class="titulo_anuncio_publicado">
                                    VENDO BONITO PERRO
                                    <br/>
                                    VENDO
                                </div>
                                <br/>
                                <strong>
                                    Precio:
                                </strong>

                                <br/>
                                <font> Fecha de publicacion:12-06-2014</font>
                                <br/>
                                <font>Sección: Venta</font>
                                <br/>
                                <font>Raza: Cairn Terrier</font>
                                <br/>
                                <font>Género: Macho</font>
                                <br/>
                                <font>Lugar: Queretaro (Queretaro)</font>

                                <br/>
                                <br/>
                                <ul class="boton_naranja">
                                    <li onclick="muestra('contenedor_contactar_previo');">
                                        Contactar al anunciante
                                    </li>
                                </ul>
                                <br/>
                                <ul class="boton_gris">
                                    <li>
                                        <img src="<?php echo base_url() ?>images/favorito.png"/>Agregar a Favoritos
                                    </li>
                                </ul>

                            </div>
                            <br/>

                            <div class="contenedor_del_detalle">

                                <div class="titulo_anuncio_publicado">
                                    MÁS DETALLES
                                </div>

                                <div class="descripcion_del_anuncio">

                                    ksdjfkjslfk fdglksj gkfdsjg jgfkdjgkfd gfdgkdf gfdskj fgsfkjg sdlkf gjkfdsg fdlkgjdfl glfdsjg dflkgj
                                    dfgj flkgjf gjfd gfdjg fdlg fdlg fjgfd gjdslf gkgj lgjfgk gjfdkg lkgjf gjjkgj s
                                </div>
                                <br/>
                                <ul class="boton_naranja_dos">
                                    <li id="ver_video" onclick="muestra('video_previo');">
                                        Ver video
                                    </li>
                                </ul>

                                <div id="video_previo" class="desplegar_detalles" style="display:none;">
                                    <br/>

                                    <div class="titulo_anuncio_publicado">
                                        VIDEO
                                    </div>

                                    <iframe class="youtube_video"
                                            src="<?php echo base_url() ?>http://www.youtube.com/embed/YlmidIPuZ58"></iframe>


                                </div>


                                <ul class="boton_rojo_dos">
                                    <li>
                                        <img src="<?php echo base_url() ?>images/alert.png"/>
                                        Denunciar Anuncio
                                    </li>
                                </ul>

                                <div class="consejos_advertencias">

                                    - QuierounPerro.com te invita a que antes de comprar pienses en adoptar, ya que hoy en día hay
                                    millones de perros sin hogar que deben ser sacrificados.
                                    <br/>
                                    - Tener un perro conlleva una serie de responsabilidades, cuidados y atenciones que debes considerar
                                    antes de comprar uno.
                                    <br/>
                                    - Infórmate de los cuidados especiales que debes de tener con la raza específica que estás
                                    comprando.
                                    <br/>
                                    - NUNCA compres una nueva mascota sin verla físicamente antes.
                                    <br/>
                                    - NUNCA hagas depósitos o transferencias bancarias a través de medios donde tu dinero no pueda ser
                                    rastreado, como lo son Money Gram y Western Union.
                                    <br/>
                                    - NUNCA pagues por un perro con registro de pedigree AKC si no te muestran los certificados, ya que
                                    corres el riesgo de que sea una estafa y nunca te los entreguen. Exige ver los papeles y asegúrate
                                    de que el nombre del criador esté en el certificado.
                                    <br/>
                                    - Cuando vayas a ver al vendedor, nunca vayas solo y revisa los alrededores.
                                    <br/>
                                    - El vendedor también debe estar interesado en ti y en manos de quién dejará a su perro.
                                </div>


                            </div>

                            <br/>

                        </div>

                        <div id="contendedor_morado" class="contenedor_morado">
                            <ul class="morado_15_sinmargen">
                                <li onclick="">
                                    Editar
                                </li>
                            </ul>

                            <ul class="morado_15_sinmargen">
                                <li onclick="muestra('paso_cinco');
                                        oculta('paso_cuatro');">
                                    Continuar
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!-- final del contendor paso 4 -->


                <!-- Inicio paso 5 -->
                <div id="paso_cinco" style="display:none;">
                    <div class="numeros_publicar_anuncio">
                        <ul class="listado_numeros_anuncio">
                            <li>1</li>
                            <li>2</li>
                            <li>3</li>
                            <li>4</li>
                            <li class="numero_seccion">5</li>
                        </ul>
                    </div>
                    <br/>

                    <div class="crerar_publicar_anuncio">
                        <img src="<?php echo base_url() ?>images/cerrar.png" onclick="oculta('contenedor_publicar_anuncio');"/>

                    </div>

                    <div class="descipcion_pasos_mediano">
                        <div class="titulo_de_pasos"> PUBLICAR ANUNCIO</div>
                        <div class="instrucciones_pasos"> Detalle de compra:</div>
                        <br/>

                        <div class="tipo_paquete_pago">
                            <img src="<?php echo base_url() ?>images/pago_lite.png"/>
                        </div>
                        <div class="divisor_morado"></div>

                        <div class="descripcion_paquete_pago">
                            <div class="titulo_descripcion_paquete"> INCLUYE</div>
                            <div style="padding:15px;">
                                <p> * 1 foto </p>

                                <p>* Texto de 50 caracteres </p>

                                <p>* Vigencia de 30 días. </p>
                            </div>
                        </div>
                        <div class="divisor_morado"></div>
                        <div class="tipo_paquete_pago">
                            <div class="titulo_descripcion_paquete"> TOTAL</div>
                            <div class="total_compra"><p> $ 89.00 <font class="moneda"> MX </font></p>
                            </div>

                        </div>

                        <br/>
                        <br/>

                        <div style="margin-top:150px;">
                            <div class="sub_instrucciones_pasos"><img style=" margin-left:15px;"
                                                                      src="<?php echo base_url() ?>images/mini_cupon.png"/> Cupones
                                disponibles <font> 2 </font></div>
                            <div style="padding:15px;">
                                <p>Si lo deseas pudes usar alguno de tus cupones</p>

                                <form class="radios_cupones" action="">
                                    <input type="radio" name="radiog_dark" id="radio_pago1" class="css-checkbox"/><label
                                        for="radio_pago1" class="css-label radGroup2"> 10% de descuento</label>
                                    <br/>
                                    <input type="radio" name="radiog_dark" id="radio_pago2" class="css-checkbox" checked="checked"/>
                                    <label for="radio_pago2" class="css-label radGroup2">5% de descuento</label>
                                    <br/>
                                    <input type="radio" name="radiog_dark" id="radio_pago3" class="css-checkbox"/><label
                                        for="radio_pago3" class="css-label radGroup2"> 20% de descuento</label>
                                    <br/>
                                </form>
                            </div>
                        </div>
                        <ul class="morado_15">

                            <li onclick="">
                                Pagar
                            </li>

                        </ul>
                    </div>

                </div>
                <!-- Fin  paso 5 -->


            </div>
        </div>
        </div>
        <!-- Fin del contenedor publicar anucio fondo negro -->

        <div class="titulo_seccion">
            TIENDA
        </div>
        <div class="contenedor_buscado">


        </div>

        <div id="contenedor_central">
            <div id="espacio_izquierda" class="seccion_izquierda_secciones">
                <ul class="iconos" id="iconos_grandes">
        <li <?php if ($this->session->userdata('idUsuario') !== FALSE): ?>  onclick="window.location='<?= base_url() ?>carrito';" <?php else: ?>  <?php endif; ?>>
            <div class="indicadores"> 
                <?php echo $carritoT ?>
                
            </div> 

            <img src="<?php echo base_url() ?>images/compras.png"/></li>
        <li 
        <?php if ($this->session->userdata('idUsuario') !== FALSE): ?>
       <?php else: ?> onclick="muestra('contenedor_login');oculta('envio_con');muestra('ingreso_normal');" <?php endif; ?>>
        
        
        
            <div class="indicador">
             <?php if ($this->session->userdata('idUsuario') !== FALSE): ?>
             <img src="images/indicador_si.png" title="Ya estas logueado">
             <?php else: ?>
             <img src="images/indicador_no.png">
             <?php endif; ?>
              </div>
            <img src="<?php echo base_url() ?>images/sesion.png"/></li> 
            
        <li <?php if ($this->session->userdata('idUsuario') !== FALSE): ?>  <?php else: ?>onclick="muestra('contenedor_registro');" <?php endif; ?>>
            <div class="indicador"> 
            <?php if ($this->session->userdata('idUsuario') !== FALSE): ?>
             <img src="images/indicador_si.png" title="Ya estas registrado">
             <?php else: ?>
             <img src="images/indicador_no.png">
             <?php endif; ?>
             </div>
            <img src="<?php echo base_url() ?>images/registrate.png"/>
        </li>
    </ul>
            </div>


            <div class="contenedor_central">
                <br/>
                <br/>
                <?php if ($this->session->flashdata('info')): ?>
                    <?php echo $this->session->flashdata('info'); ?>
                <?php endif; ?>
                <!-- item container -->
                <div style="position: relative;">
                    <div id="itemContainer" style="overflow-y: auto; height: auto!important;">
                        <!-- Inicio FILA -->
                    <?php $fila = 1;?>
                        <?php
                        if ($catalogo != null):
                            foreach ($catalogo as $item):
                                ?>
                                <!-- INICIO contenedor anuncio  -->
                                <!--<input type="hidden" name="productoID" id="productoID" value="<?php echo $item->productoID ?>" />-->
                                <div class="contenedor_producto" id="<?php echo $item->productoID ?>">
                                    <div class="contenedor_picture">
                                        <?php if ($item->foto != null): ?>
                                            <img src="<?php echo base_url() ?>images/productos/<?php echo $item->foto ?>"
                                                 width="184" height="158"/>
                                             <?php else: ?>
                                            <img src="<?php echo base_url() ?>images/productos/default.png" width="184"
                                                 height="158"/>
                                             <?php endif; ?>
                                    </div>
                                    <div class="contenedor_descripcion_precio_producto detalleProducto"
                                         id="<?php echo $item->productoID ?>">
                                        <font class="nombre_producto"><?php echo $item->nombre ?></font>
                                        <br/>
                                        <font class="precio_producto"><?php echo '$' . $item->precio ?></font>
                                    </div>

                                    <div>
                                    </div>
                                </div>


                                <!-- Fin contenedor annuncio -->
 <?php if (4 > $fila++):?>
                <!-- Inicio margen falso -->
                <div class="margen_derecho_20">

                </div>
            <?php else:?>
                <?php $fila = 1;?>
            <?php endif;?>
            <!-- FIN margen falso -->

                                <?php
                            endforeach;
							
							
                        endif;
                        ?>
                        <!-- FIN FILA ---->
                    </div>
                </div>
                <br/>
                <?php echo $this->pagination->create_links(); ?>

                <div style="margin: 0px auto; padding:10px; text-align:center;">
                    <!-- navigation holder -->
                    <div class="holder"></div>
                </div>
            </div>


            <div class="seccion_derecha_paquetes">
                <ul class="aqui_crear_anuncio">
                    <li onclick="muestra('contenedor_publicar_anuncio');">

                    </li>
                </ul>
            </div>
        </div>


        <div class="slideshow_tres" style="clear: both;">
            <?php
            if (is_logged() && ($this->session->userdata('tipoUsuario') == 2 || $this->session->userdata('tipoUsuario') == 3)) {
                if ($banner != null) {
                    foreach ($banner as $contenido) {
                        if ($this->session->userdata('zonaID') == $contenido->zonaID && $contenido->posicion == 3 && $contenido->seccionID == $seccion) {
                            ?>
                            <img src="<?php echo base_url() ?>images/<?php echo $contenido->imgbaner; ?>" width="638"
                                 height="93"/>

                            <?php
                        }
                    }
                }
            } else {
                foreach ($banner as $contenido) {
                    if ($contenido->zonaID == 9 && $contenido->posicion == 3 && $contenido->seccionID == $seccion) {
                        ?>    <img src="<?php echo base_url() ?>images/<?php echo $contenido->imgbaner; ?>" width="638"
                             height="93"/>
                             <?php
                         }
                     }
                 }
                 ?>
        </div>
        <br/>
        <div class="division_menu_inferior"></div>
        <?php $this->load->view('general/footer_view'); ?>
        
    </body>
</html>