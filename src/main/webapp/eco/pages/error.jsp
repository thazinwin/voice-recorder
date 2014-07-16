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
    <meta name="description" content="VoiceRecorder">


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

		<div class="container">
			<div class="row-fluid">
				<div class="alert alert-danger">
					<strong>Oh snap!</strong> <a href="http://localhost:8080/VoiceRecorder/eco/global_record.action" class="alert-link" sl-processed="1">Change a few things up</a> and try submitting again.
				</div>
			</div>
		</div>
    </div>
 </body>
</html>