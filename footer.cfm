		
		
		
			</div><!-- / .page-wrapper -->
        </div><!-- /.wrapper -->
		
		
		<!--- // footer --->	
		
		
		<cfoutput>
			<div class="footer fixed">
				<div class="pull-right">
					Game Video &amp; Analytics
				</div>
				<div>
					<strong>&copy; #year( now() )# Qwikcut.com.  All Rights Reserved.</strong>
				</div>				
			</div>
		</cfoutput>
		
		<!-- Mainly scripts -->
		<script src="js/jquery-2.1.1.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/plugins/metisMenu/jquery.metisMenu.js"></script>
		<script src="js/plugins/slimscroll/jquery.slimscroll.min.js"></script>	
		
		<!-- Custom and plugin javascript -->
		<script src="js/inspinia.js"></script>
		
		
		<!-- date picker -->
		<script src="js/plugins/datapicker/bootstrap-datepicker.js"></script>
		<!-- Date range picker -->
		<script src="js/plugins/daterangepicker/daterangepicker.js"></script>
			<script>
			$(document).ready(function(){
				$('#data_1 .input-group.date').datepicker({
					todayBtn: "linked",
					keyboardNavigation: false,
					forceParse: false,
					calendarWeeks: true,
					autoclose: true
				});
				$('#data_5 .input-daterange').datepicker({
					keyboardNavigation: false,
					forceParse: false,
					autoclose: true
				});
			});
		</script>
		
		
		

		<!-- Flot 
		<script src="js/plugins/flot/jquery.flot.js"></script>
		<script src="js/plugins/flot/jquery.flot.tooltip.min.js"></script>
		<script src="js/plugins/flot/jquery.flot.resize.js"></script>		
		<script src="js/plugins/chartJs/Chart.min.js"></script>		
		<script src="js/plugins/peity/jquery.peity.min.js"></script>		
		<script src="js/demo/peity-demo.js"></script>
		-->
	</body>
</html>