/** @jsx React.DOM */
$(document).ready(function() {
        $('.chatFixed').click(function() {
                $('.chatBox').slideToggle("fast");
        });


});
  window.ChatBox = React.createClass({
    render: function() {
      return (
        <div>
        <div className="topChatBar"></div>
        </div>
        );
    }
  });



