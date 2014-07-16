<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath()+"/eco";
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>HTML5 Voice Recorder</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="HTML5 VoiceRecorder">


    <!-- Le styles -->
    <link href="<%=path%>/bootstrap/css/bootstrap.css" rel="stylesheet">
    <style>
      body {
        padding-top: 60px; /* 60px to make the container go all the way to the bottom of the topbar */
      }
      .soundBite input {
        margin-right: 4px;
      }
    </style>
    <link href="<%=path%>/bootstrap/css/bootstrap-responsive.css" rel="stylesheet">

    <!-- Le fav and touch icons -->
    <link rel="shortcut icon" href="<%=path%>/bootstrap/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="<%=path%>/bootstrap/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="<%=path%>/bootstrap/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="<%=path%>/bootstrap/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="<%=path%>/bootstrap/ico/apple-touch-icon-57-precomposed.png">
	<!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="<%=path%>/jquery/js/jquery-1.7.2.js"></script>
    <script src="<%=path%>/bootstrap/js/bootstrap-transition.js"></script>
    <script src="<%=path%>/bootstrap/js/bootstrap-alert.js"></script>
    <script src="<%=path%>/bootstrap/js/bootstrap-modal.js"></script>
    <script src="<%=path%>/bootstrap/js/bootstrap-dropdown.js"></script>
    <script src="<%=path%>/bootstrap/js/bootstrap-scrollspy.js"></script>
    <script src="<%=path%>/bootstrap/js/bootstrap-tab.js"></script>
    <script src="<%=path%>/bootstrap/js/bootstrap-tooltip.js"></script>
    <script src="<%=path%>/bootstrap/js/bootstrap-popover.js"></script>
    <script src="<%=path%>/bootstrap/js/bootstrap-button.js"></script>
    <script src="<%=path%>/bootstrap/js/bootstrap-collapse.js"></script>
    <script src="<%=path%>/bootstrap/js/bootstrap-carousel.js"></script>
    <script src="<%=path%>/bootstrap/js/bootstrap-typeahead.js"></script>


    <script type="text/javascript" src="<%=path%>/app/js/ACFIRFilter.js"></script>
    <script type="text/javascript" src="<%=path%>/app/js/ACAAFilter.js"></script> 
    <script type="text/javascript" src="<%=path%>/app/js/ACSpectrum.js"></script>    
    <script type="text/javascript" src="<%=path%>/app/js/ACFFT.js"></script>
    <script type="text/javascript" src="<%=path%>/app/js/SpectrumWorker.js"></script>
    <script type="text/javascript" src="<%=path%>/app/js/SpectrumDisplay.js"></script>
    <script type="text/javascript" src="<%=path%>/app/js/audioplayback.js"></script>
    <script type="text/javascript" src="<%=path%>/app/js/filedropbox.js"></script>
    <script type="text/javascript" src="<%=path%>/app/js/fft.js"></script>
    <script type="text/javascript" src="<%=path%>/app/js/audioLayerControl.js"></script>
    <script type="text/javascript" src="<%=path%>/app/js/audiosequence.js"></script>
    <script type="text/javascript" src="<%=path%>/app/js/AudioSequenceEditor.js"></script>
    <script type="text/javascript" src="<%=path%>/app/js/mathutilities.js"></script>
    <script type="text/javascript" src="<%=path%>/app/js/wavetrack.js"></script>
    <script type="text/javascript" src="<%=path%>/app/js/binarytoolkit.js"></script>
    <script type="text/javascript" src="<%=path%>/app/js/filesystemutility.js"></script>
    <script type="text/javascript" src="<%=path%>/app/js/editorapp.js"></script>

    <script src="<%=path%>/js/lib/recorder.js"></script>
    <script src="<%=path%>/js/recordLive.js"></script>
    <script src="<%=path%>/js/sequencer.js"></script>
    <script src="<%=path%>/js/drone.js"></script>

    <script type="text/javascript">
      $(window).load(function()
      {
        $('.editor.container').addClass('invisible');
        onDocumentLoaded();
      });
    </script>
  </head>

  <body>
  
    <div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <a class="brand" href="#">HTML5 Voice Recorder</a>
        </div>
      </div>
    </div>
	
    <div class="recorder container">
     <p>Make sure you are using a recent version of Google Chrome, at the moment this only works with Google Chrome Canary. You also need to enable Web Audio Input</p>

      <h2>Record</h2>
      <p>Record monitor volume: <input type="range" max="1" step="0.1" value="0" onchange="changeVolume(this.value)"/></p>
      <p>
        <button class="btn btn-primary" onclick="startRecording(this);">Record</button>
        <button class="btn btn-warning" onclick="stopRecording(this);" disabled>Stop</button>
      </p>
      
      <h2>Sounds</h2>
      <p>
        Sequencer
        <button class="btn btn-primary" onclick="startSequencer(this);">Play</button>
        <button class="btn btn-warning" onclick="stopSequencer(this);" disabled>Stop</button>
      </p>
      <table id="recordingslist">
        <tr>
          <th>Sound</th>
          <th></th>
          <th></th>
          <th id="sequencerBoxes">
            <!-- <p>Sequence</p> -->
            <input type="checkbox"/>
            <input type="checkbox"/>
            <input type="checkbox"/>
            <input type="checkbox"/>
            <input type="checkbox"/>
            <input type="checkbox"/>
            <input type="checkbox"/>
            <input type="checkbox"/>
          </th>
        </tr>
        <tr>
          <th>Drone</th>
          <th>
            <label for='BaseNote'>Base Note: <span class='controlVal'></span></label>
            <input class='control' id='BaseNote' type='range' min='40' max='100' value='63'>
          </th>
          <th>
            <label for='NumOsc'>Number of Generators: <span class='controlVal'></span></label>
            <input class='control' id='NumOsc' type='range' min='1' max='40' value='40'>
          </th>
          <th>
            <!-- <input type="checkbox" id="droneToggle" checked/> -->
          </th>
        </tr>
      </table>
	  <div class="row-fluid">
	   <h2>File Share</h2>
			<div class="span12">
				 <form id="form1" name="form1" method="POST" action="<%=path %>/global_sendEmail.action" enctype="multipart/form-data" class="form-horizontal">
					 <div class="control-group">
						<label class="control-label" for="userName"><strong>User Name :</strong></label>
						 <div class="controls">
							<input type="text" name="userName" id="userName" >
						</div>
					 </div>
					 <div class="control-group">
						<label class="control-label" for="mailTo"><strong>Email :</strong></label>
						 <div class="controls">
							<input type="text" name="mailTo" id="mailTo">
						 </div>
					</div>
					<div class="control-group">
						<label class="control-label" for="userName"><strong>Upload :</strong></label>
						<div class="controls">
							<input type="file" name="file" id="file" />
						</div>
					</div>
					<div class="control-group">
						<div class="controls">
						  <button class="btn btn-success" name="submit" onclick="sendEmail(this);">Send Email</button>
						  <button class="btn btn-danger" type="reset" name="reset" onclick="resetInfo(this);">Reset</button>
						</div>
					</div>
				</form>
			</div>
		</div>
    </div>
    <div class="editor container">
      <div class="row">
        <div class="span12">
          <center>
             <div class="btn-toolbar">
            <div class="btn-group">
              <a class="btn btn-primary" onclick="$('#audioLayerControl')[0].copy();"><i class="icon-share icon-white"></i> Copy</a>
              <a class="btn btn-primary" onclick="$('#audioLayerControl')[0].paste();"><i class="icon-chevron-down icon-white"></i> Paste</a>
              <a class="btn btn-primary" onclick="$('#audioLayerControl')[0].cut();"><i class="icon-chevron-up icon-white"></i> Cut</a>
              <a class="btn btn-primary" onclick="$('#audioLayerControl')[0].del();"><i class="icon-remove icon-white"></i> Delete</a>
            </div>
            <div class="btn-group">
              <a class="btn btn-success" onclick="$('#audioLayerControl')[0].selectAll();"><i class="icon-resize-horizontal icon-white"></i> Select All</a>
              <a class="btn btn-success" onclick="$('#audioLayerControl')[0].zoomIntoSelection();"><i class="icon-plus-sign icon-white"></i> Zoom To Selection</a>
              <a class="btn btn-success" onclick="$('#audioLayerControl')[0].zoomToFit();"><i class="icon-fullscreen icon-white"></i> Zoom To Fit</a>
            </div>
          </div>
        </center>
        </div>
      </div>
      <hr />
      <div class="row">
        <div class="span4">
          <h6>Spectrum</h6>
          <div class="well">
            <div id="spectrum"></div>
          </div>
        </div>
        <div class="span8">
          <h6>Editor</h6>
          <div class="well">
             <audioLayerControl id="audioLayerControl" title="CloudCompany.mp3" />
          </div>
          <!--<div id="editor">
                <div id="editorbox">
                    <audioLayerControl id="audioLayerControl" title="CloudCompany.mp3" />
                </div>
            </div>-->
        </div>
      </div>
      <hr>
      <div class="row">
        <div class="span12">
          <center>
            <div class="btn-toolbar">
              <div class="btn-group">
                <a id="btn_play" class="btn btn-success btn-large" onclick="$('#audioLayerControl')[0].play()" rel="tooltip" title="first tooltip"><i class="icon-play icon-white"></i></a>
                <a id="btn_pause" class="btn btn-success btn-large disabled"><i class="icon-pause icon-white"></i></a>
                <a id="btn_stop" class="btn btn-success btn-large" onclick="$('#audioLayerControl')[0].stop()"><i class="icon-stop icon-white"></i></a>
                <a id="btn_loop" class="btn btn-warning btn-large" data-toggle="button" onclick="$('#audioLayerControl')[0].toggleLoop();"><i class="icon-repeat icon-white"></i></a>
              </div>
              <div class="btn-group">
                <!-- <a class="btn btn-large btn-primary" onclick="$('#audioLayerControl')[0].save($('#savelink')[0]);"><i class="icon-fire"></i> Render</a> -->
                <button class="btn btn-large btn-success" id="savelink" onclick="$('#audioLayerControl')[0].saveBack();"><i class="icon-download"></i> Save</button>
              </div>
            </div>
          </center>
        </div>
      </div>
      <div class="row">
        <div class="span4 offset4">
          <div class="progress progress-striped active">
            <div id="app-progress" class="bar" style="width: 0%;"></div>
          </div>
        </div>
      </div>  
      <br>
      <div class="row">
        <div class="span1"><br></div>
        <div class="span2">
          <h6>Gain</h6>
          <div class="well" style="height: 130px; position:relative">
            <p>Change the volume of the selected audio sequence with the given gain multiplicator.</p>
            
              <div class="pull-right" style=" position:absolute; bottom: 5px; width: 100%;" >
                <div class="btn-group" >
                  
                    <button class="btn btn-success" onclick="decrease_db()"><i class="icon-minus"></i></button>
                    <button id="gain-db" class="btn disabled" onclick="gain_btn_clicked()">0 db</button>
                    <button class="btn btn-success" onclick="increase_db()"><i class="icon-plus"></i></button> 
                </div>
              </div>
            <script type="text/javascript">
                var db_gain = 0;

                function decrease_db()
                {
                  --db_gain;
                  update_db_gain_btn();
                }

                function increase_db()
                {
                  ++db_gain;
                  update_db_gain_btn();
                }

                function update_db_gain_btn()
                {
                  var gain_btn = $('#gain-db')[0];

                  gain_btn.innerHTML = db_gain + ' db'; 

                  if (db_gain === 0)
                  {
                    gain_btn.className = 'btn disabled';
                  }
                  else
                  {
                    gain_btn.className = 'btn btn-primary';
                  }
                }

                function gain_btn_clicked()
                {
                  $('#audioLayerControl')[0].filterGain(db_gain);
                  db_gain = 0;
                  update_db_gain_btn();
                }
                </script>
          </div>
        </div>
        <div class="span2">
          <h6>Normalize</h6>
          <div class="well" style="height: 130px; position:relative">
            <p>Adjust the volume to the maximum of the selected audio sequence.</p>
            <a style="position:absolute; bottom: 5px; right: 5px"  class="btn btn-primary pull-right" onclick="$('#audioLayerControl')[0].filterNormalize();">Apply</a>
            <br>
          </div>
        </div>
        <div class="span2">
          <h6>Silence</h6>
          <div class="well" style="height: 130px; position:relative">
            <p>Silence the selected audio sequence</p>
            <a style="position:absolute; bottom: 5px; right: 5px"  class="btn btn-primary pull-right" onclick="$('#audioLayerControl')[0].filterSilence();">Apply</a>
            <br>
          </div>
        </div>
        <div class="span2">
          <h6>Fade In</h6>
          <div class="well" style="height: 130px; position:relative">
            <p>Create a linear fade int of the selected audio sequence</p>
            <a style="position:absolute; bottom: 5px; right: 5px"  class="btn btn-primary pull-right" onclick="$('#audioLayerControl')[0].filterFadeIn();">Apply</a>
            <br>
          </div>
        </div>
        <div class="span2">
          <h6>Fade Out</h6>
          <div class="well" style="height: 130px; position:relative">
            <p>Create a linear fade out of the selected audio sequence</p>
            <a style="position:absolute; bottom: 5px; right: 5px" class="btn btn-primary pull-right" onclick="$('#audioLayerControl')[0].filterFadeOut();">Apply</a>
            <br>
          </div>
        </div>
        <div class="span1">
        </div>
      </div>
	 </div>
  </body>
</html>