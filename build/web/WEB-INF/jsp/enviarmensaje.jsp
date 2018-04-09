<%-- 
    Document   : enviarmensaje
    Created on : 07-nov-2017, 10:41:05
    Author     : Norhan
--%>

<%--<%@page contentType="text/html" pageEncoding="UTF-8"%>--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
    <%@ include file="infouser.jsp" %>
    <%--<%@ include file="menu.jsp" %>--%>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Send Message </title>
        <script>

            function rellenarText() {
                var message = CKEDITOR.instances.NotificationMessage.getData();
                $('#destino option').prop('selected', true);
                $('#NotificationMessage').val(message);
            }


            $(document).ready(function () {
                arrayTotalAlumnos = $("#origen option");

                $('.pasar').click(function () {
                    var exist = false;
                    $('#destino option').each(function () {
                        if ($('#origen option:selected').val() === $(this).val())
                            exist = true;
                    });

                    if (!exist)
                        !$('#origen option:selected').clone().appendTo('#destino');

                    $('#destino option').first().prop('selected', true);
                    return;
                });


                $('.quitar').click(function () {
                    !$('#destino option:selected').remove();
                    $('#destino option').first().prop('selected', true);

                    var alumnosSelected = $('#destino option').length;
                    var objectiveSelected = $('#objective').val();
                    if (alumnosSelected === 0 || (objectiveSelected === 0 || objectiveSelected === null || objectiveSelected === '')) {
                        $('#saveEdit').attr('disabled', true);
                    }
                    return;
                });
                $('.pasartodos').click(function () {
                    $('#origen option').each(function () {

                        var valueInsert = $(this).val();
                        var exist = false;
                        $('#destino option').each(function () {
                            if (valueInsert === $(this).val())
                                exist = true;
                        });

                        if (!exist)
                            $(this).clone().appendTo('#destino');

                        var objectiveSelected = $('#objective').val();
                        if (objectiveSelected === 0 || objectiveSelected === null || objectiveSelected === '') {
                            $('#saveEdit').attr('disabled', true);
                        }
                    });

                    var numAlum = $('#destino option').length;
                    if (document.getElementById("objective").value !== 'Select Objective' && document.getElementById("objective").value !== '' && document.getElementById("NameLessons").value !== '' && document.getElementById("comments").value !== '' && $('#fecha input').val() !== '' && $('#horainicio input').val() !== '' && $('#horafin input').val() !== '' && numAlum > 0) {
                        $('#saveEdit').attr('disabled', false);
                    } else {
                        $('#saveEdit').attr('disabled', true);
                    }

                    $('#destino option').first().prop('selected', true);
                });

                $('.quitartodos').click(function () {
                    $('#destino option').each(function () {
                        $(this).remove();
                    });
                    $('#saveEdit').attr('disabled', true);
                });

                $("#tg").treegrid();
                table = $('#table_students').DataTable(
                        {
                            "searching": true,
                            "paging": false,
                            "ordering": false,
                            "info": false,
                            columns: [
                                {data: 'id',
                                    visible: false},
                                {data: 'name'}
                            ]
                        });

                $('#table_students tbody').on('click', 'tr', function () {

                    data = table.row(this).data();
                    //if(!containsDest($('#destinatarios').valueOf(),data1))
                    var campo = $('#destinatarios').val();
                    var name = $('#names').val();
                    if (!name.includes(data.name))
                        if (name === "")
                            $('#names').val(data.name + ". ");
                        else
                            $('#names').val(name + data.name + ". ");
                    if (!campo.includes(data.id))
                        if (campo === "")
                            $('#destinatarios').val("['" + data.id + "'");
                        else
                            $('#destinatarios').val(campo + "," + "'" + data.id + "'");
                });

                $('#fecha').datetimepicker({
                    format: 'YYYY-MM-DD',
//            locale: userLang.valueOf(),
                    daysOfWeekDisabled: [0, 6],
                    useCurrent: false//Important! See issue #1075
                            //defaultDate: '08:32:33',


                });
                $('option').on('click', function () {
                    var ss = 2;
                    if ($("#pepe :selected").text() === "Select level" || $("#pepe :selected").text() === "Select class") {
                        $("#origen").empty();
                        for (var i = 0, l = arrayTotalAlumnos.length; i < l; i++) {
                            $("#origen").append(arrayTotalAlumnos[i])
                        }
                    }
                })
            });


            var ajax;
            var d = new Date();

            var month = d.getMonth() + 1;
            var day = d.getDate();
            var hour = d.getHours();
            var minute = d.getMinutes();
            var second = d.getSeconds();

            var currentTime = d.getFullYear() + '-' +
                    (('' + month).length < 2 ? '0' : '') + month + '-' +
                    (('' + day).length < 2 ? '0' : '') + day + ' ' +
                    (('' + hour).length < 2 ? '0' : '') + hour + ':'
                    + (('' + minute).length < 2 ? '0' : '') + minute;

            function funcionCallBackSelectStudent()
            {
                if (ajax.readyState === 4) {

                    if (ajax.status === 200) {
                        //data
                        var json = JSON.parse(ajax.responseText);
                        var info = JSON.parse(json.info);
                                            var subjects = JSON.parse(json.sub);
                        var prog = JSON.parse(json.prog);
                        //first load the demographics
                        $('#gradelevel').text(info.level_id);
                        $('#nextlevel').text(info.nextlevel);
                        $('#student').text(info.nombre_students);
                        $('#studentid').val(info.id_students);
                        if (typeof info.foto === 'undefined') {
                            $('#foto').attr('src', '../recursos/img/NotPhoto.png');
                        } else {
                            $('#foto').attr('src', "ftp://AH-ZAF:e3f14+7mANDp@ftp2.renweb.com/Pictures/" + info.foto);
                        }
                        //load the objectives tracking tree
                        $('#tg').treegrid({
//                    view: myview,        
                            data: prog.children,
                            idField: 'id',
                            treeField: 'name',
                            columns: [[
                                    {title: 'Name', field: 'name'},
                                    {title: 'No.of presentations planned', field: 'noofplannedlessons'},
                                    {title: 'No.of presentations done', field: 'noofarchivedlessons'},
                                    {title: 'Progress', field: 'progress', formatter: formatProgress},
                                    {title: 'Final rating', field: 'rating'}
                                ]]

                        });
                        //hide the objectives in case a previous student was selected
                        $('#divTableObjective').addClass('hidden');//to avoid having the general comments of the previous selected student
                        $('#divNotObjective').addClass('hidden');
                        $('#subjects').empty();
                        $.each(subjects, function (i, item) {
                             $('#subjects').append('<option value= "' + subjects[i].id + '">' + subjects[i].name + '</option>');
                        });

                        $('#loadingmessage').hide();  // hide the loading message.
                    }
                }
            }
            ;


            function comboSelectFilter() {
                var filter = $('#filter').val();

                $.ajax({
                    type: "POST",
                    url: "filter.htm?seleccion=" + filter,
                    data: filter,
                    dataType: 'text',
                    success: function (data) {
                        var json = JSON.parse(data);
                        $('#pepe').remove();
                        var anadir = "";
                        if (!(filter === "1")) {
                            anadir = "<select class='form-control' name='levelStudent' id='pepe' style='width: 100% !important;' onchange='comboSelectionLevelStudent()'>";
                        } else {
                            anadir = "<select class='form-control' name='levelStudent' id='pepe' style='width: 100% !important;' onchange='comboSelectionClassStudent()'>";
                        }
                        $.each(json, function (i) {
                            anadir += "<option value='" + json[i].id + "'>" + json[i].name + "</option>";
                        });
                        anadir += "</select>";
                        $('#filtro').append(anadir);
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(thrownError);
                    }

                });
            }

            function comboSelectionLevelStudent()
            {

                var nivel = $('#pepe').val();
                if (nivel !== "" && nivel !== "undefined") {
                    $.ajax({
                        type: "POST",
                        url: "studentlistLevel.htm?nivel=" + nivel,
                        data: nivel,
                        dataType: 'text',
                        success: function (data) {
                            var json = JSON.parse(data);
                            //var table = $('#table_students').DataTable();
                            $('#origen').empty();
                            $.each(json, function (i) {
                                $('#origen').append('<option value="' + json[i].id_students
                                        + '" >' + json[i].nombre_students + '</option>');
                            });

                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                            console.log(xhr.status);
                            console.log(xhr.responseText);
                            console.log(thrownError);
                        }

                    });
                } else {
                    $("#origen").empty();
                    for (var i = 0, l = arrayTotalAlumnos.length; i < l; i++) {
                        $("#origen").append(arrayTotalAlumnos[i])
                    }
                }
            }

            function comboSelectionClassStudent()
            {
                var nivel = $('#pepe').val();
                if (nivel !== "" && nivel !== "undefined") {
                    $.ajax({
                        type: "POST",
                        url: "studentclassLevel.htm?nivel=" + nivel,
                        data: nivel,
                        dataType: 'text',
                        contentType: 'charset:utf-8',
                        success: function (data) {
                            //var data2 = utf8_encode(data);
                            //console.log(data);
                            var json = JSON.parse(data);
                            //var table = $('#table_students').DataTable();
                            $('#origen').empty();
                            $.each(json, function (i) {
                                //console.log(json[i].nombre_students);
                                $('#origen').append('<option value="' + json[i].id_students
                                        + '" >' + json[i].nombre_students + '</option>');
                            });

                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                            console.log(xhr.status);
                            console.log(xhr.responseText);
                            console.log(thrownError);
                        }

                    });
                } else {
                    $("#origen").empty();
                    for (var i = 0, l = arrayTotalAlumnos.length; i < l; i++) {
                        $("#origen").append(arrayTotalAlumnos[i])
                    }
                }
            }

            function comboSelectionLevel()
            {
                if (window.XMLHttpRequest) //mozilla
                {
                    ajax = new XMLHttpRequest(); //No Internet explorer
                } else
                {
                    ajax = new ActiveXObject("Microsoft.XMLHTTP");
                }

                $('#createOnClick').attr('disabled', true);
                ajax.onreadystatechange = funcionCallBackSubject;
                var seleccion1 = document.getElementById("level").value;
                ajax.open("POST", "progressbystudent.htm?option=subjectlistLevel&seleccion1=" + seleccion1, true);

                ajax.send("");

            }

            function selectionStudent()
            {
                var selectStudent = data1;
                if (window.XMLHttpRequest) //mozilla
                {
                    ajax = new XMLHttpRequest(); //No Internet explorer
                } else
                {
                    ajax = new ActiveXObject("Microsoft.XMLHTTP");
                }
                $('#loadingmessage').show();  // show the loading message.
                //$('#createOnClick').attr('disabled', true);
                ajax.onreadystatechange = funcionCallBackSelectStudent;

                //  var selectStudent = document.getElementsByClassName("nameStudent").value;
                ajax.open("POST", "studentPage.htm?selectStudent=" + selectStudent, true);

                ajax.send("");

            }

            $(function () {
                $('#subject').change(function () {
//        $('#LoadTemplates').parent().attr("disabled",false);
//        $('#LoadTemplates').attr("disabled",false);
                    $('#LoadTemplates').children().removeClass("disabled");
                });

                $('#LoadTemplates').change(function () {
                    if ($("input:radio[name='options']:checked").val() === 'option1') {
                        $("#lessons").attr("disabled", true);
                        $('#divCrearLessons').removeClass('hidden');
                        $('#divLoadLessons').addClass('hidden');
//    $("#NameLessons").attr("disabled", true);
                    } else {
                        $("#lessons").attr("disabled", false);
                        $('#divLoadLessons').removeClass('hidden');
                        $('#divCrearLessons').addClass('hidden');
//    $("#NameLessons").attr("disabled", false);
                    }
                });
            });
        </script>

        <style>
            /*            textarea 
                        {
                        resize: none;
                        }*/
            .studentarea
            {            
                height: 500px;
                width: 100%;
                overflow-y: scroll;
            }
            .nameStudent
            {
                background-color: #D0D2D3;
                border-radius: 10px;
                margin-top: 20px;
                margin-bottom: 20px;
                padding-top: 10px;
                padding-bottom: 10px;
                min-height: 40px;
            }
            .tab-pane
            {
                padding-top: 20px;
            }
            .sinpadding
            {
                padding: 0px;
            }
            .containerPhoto
            {
                display: table;
                /*                background-color: lightgray;*/
                border-right: 1px #D0D2D3 double;
                min-height: 300px;
            }
            .cell{
                display: table-cell;
                vertical-align: middle;
            }
            #divTableObjective{
                margin-top: 20px;
            }
            .label-demographic{
                background-color: lightgray;
                text-align: center;
                padding: 5px;
                border-top-left-radius: 10px;
                border-top-right-radius: 10px;
                margin-bottom: 0px;
            }
            .demographic{
                border: 1px solid lightgray;
                padding: 5px;
                margin-bottom: 10px;
                min-height: 32px;
            }
            .btn-unbutton{
                background-color: Transparent;
                background-repeat:no-repeat;
                border: none;
                cursor:pointer;
                overflow: hidden;
                outline:none;
            }
            .dataTables_length select {

            }
            .dataTables_filter {
                display: block !important;
                float: left !important;
                text-align: left !important;
                padding-left: 16px;
            }
            .dataTables_filter input {
                display: block;
                float: left;
                width: 100%;
                height: 34px;
                padding: 6px 12px;
                margin-left: 0px !important;
                font-size: 14px;
                line-height: 1.42857143;
                color: #555;
                background-color: #fff;
                background-image: none;
                border: 1px solid #ccc;
                border-radius: 4px;
                -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
                box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
                -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
                -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
                transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
            }

        </style>
    </head>

    <body>
        <div class="container">
            <h1 class="text-center">Send Message</h1>
            <div>
                <form:form action="enviar.htm" method="POST">
                    <div class="col-xs-12 center-block form-group" style="padding-right: 0px;">
                        <div>
                            <input name="destinatarios" id="destinatarios" type="hidden" ></input>
                        </div>

                        <div id="selector_de_alumnos" class="col-xs-12">
                            <div class="form-group collapse in" id="contenedorStudents">
                                <div class="col-xs-12">
                                    <div class="col-xs-3">
                                        <label>Filter</label>  
                                        <c:set value="${user.type}" var="num"/>
                                        <c:choose>
                                            <c:when test="${num=='2'}">
                                            </c:when>    
                                            <c:when test="${num=='0'}">
                                            </c:when>
                                            <c:otherwise>
                                                <select class="form-control" id="filter" style="margin-bottom: 5px;" onchange="comboSelectFilter()">
                                                    <option value="1">Classes</option>
                                                    <option value="0">Levels</option>
                                                </select>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                                <div class="form-group collapse in">
                                    <div class="col-xs-2" id="filtro">
                                        <select class="form-control" id="pepe" style="width: 100% !important;" onchange="comboSelectionClassStudent()">
                                            <c:forEach var="levels" items="${gradelevels}">
                                                <option value="${levels.id[0]}" >${levels.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-xs-4">
                                        <select class="form-control" size="20" multiple name="origen[]" id="origen" style="width: 100% !important;" >
                                            <c:forEach var="alumnos" items="${listaAlumnos}" >
                                                <option value="${alumnos.id_students}" >${alumnos.nombre_students}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-xs-2">
                                        <div class="col-xs-12 text-center" style="padding-bottom: 10px; padding-top: 50px;">
                                            <input type="button" class="btn btn-success btn-block pasar" value="add »">
                                        </div>
                                        <div class="col-xs-12 text-center" style="padding-bottom: 10px;">
                                            <input type="button" class="btn btn-danger btn-block quitar" value="« remove">
                                        </div>
                                        <div class="col-xs-12 text-center" style="padding-bottom: 10px;">
                                            <input type="button" class="btn btn-success btn-block pasartodos" value="add all »">
                                        </div>
                                        <div class="col-xs-12 text-center" style="padding-bottom: 10px;">
                                            <input type="button" class="btn btn-danger btn-block quitartodos" value="« remove all">
                                        </div>
                                    </div>

                                    <div class="col-xs-4">
                                        <select class="form-control" size="20" multiple name="destino[]" id="destino" style="width: 100% !important;"> 

                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12" style="margin-top: 40px;">
                            <label class="control-label">Subject</label> 
                            <div class="col-xs-12">
                                <textarea name="asunto" id="asunto" rows="1" cols="40"></textarea>
                            </div>
                        </div>
                        <div class="col-xs-12">
                            <label class="control-label">Text</label>
                            <textarea name="NotificationMessage" id="NotificationMessage" required="required"></textarea>
                            <script> CKEDITOR.replace('NotificationMessage');</script>

                            <div class="col-xs-12 text-center">
                                <input class="btn btn-primary btn-lg" type="submit" name="Submit" value="send"onclick="rellenarText()">
                            </div>
                        </div>
                    </div>
                </div>
            </form:form>
        </div>

        <div class="divLoadStudent" id="loadingmessage">
            <div class="text-center"> 
                <img src='../recursos/img/large_loading.gif'/>
            </div>
        </div>
        <c:if test="${error=='error'}">
            <script>
                $(document).ready(function () {
                    $('#myModal').modal('show');
                });
            </script>
        </c:if>
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button onclick="location.href = 'start.htm';" type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <!--        <h4 class="modal-title" id="myModalLabel">Modal title</h4>-->
                    </div>
                    <div class="modal-body text-center">
                        <H1>error</H1>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>

