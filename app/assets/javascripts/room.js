// BigBlueButton open source conferencing system - http://www.bigbluebutton.org/.
//
// Copyright (c) 2018 BigBlueButton Inc. and by respective authors (see below).
//
// This program is free software; you can redistribute it and/or modify it under the
// terms of the GNU Lesser General Public License as published by the Free Software
// Foundation; either version 3.0 of the License, or (at your option) any later
// version.
//
// BigBlueButton is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
// PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License along
// with BigBlueButton; if not, see <http://www.gnu.org/licenses/>.

// Room specific js for copy button and email link.
$(document).on('turbolinks:load', function(){
  var controller = $("body").data('controller');
  var action = $("body").data('action');

  // Only run on room pages.
  if (controller == "rooms" && action == "show"){
    var copy = $('#copy');

    // Handle copy button.
    copy.on('click', function(){
      var inviteURL = $('#invite-url');
      inviteURL.select();

      var success = document.execCommand("copy");
      if (success) {
        inviteURL.blur();
        copy.addClass('btn-success');
        copy.html("<i class='fas fa-check'></i> Copy")
        setTimeout(function(){
          copy.removeClass('btn-success');
          copy.html("<i class='fas fa-copy'></i> Copy")
        }, 2000)
      }
    });

    // Handle recording emails.
    $('.email-link').each(function(){
      $(this).click(function(){
        var subject = $(".username").text() + " has invited you to view a recording.";
        var body = "To view the recording, follow the link below:\n\n" + $(this).attr("data-pres-link");
        var footer = "\n\nThis e-mail is auto-generated";
        var win = window.open("mailto:?subject=" + encodeURIComponent(subject) + "&body=" + encodeURIComponent(body) + encodeURIComponent(footer), '_blank');
        win.focus();
      });
    });
  }
});
