$(document).ready(function() {
	$("#Select").click(function() {
		if ($(".idClass").prop('checked') == false) {
			$(".idClass").prop("checked", true);
		}
		else {
			$(".idClass").prop("checked", false);

		}
	});
});
