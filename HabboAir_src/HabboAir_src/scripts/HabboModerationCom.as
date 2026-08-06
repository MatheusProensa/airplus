package
{
   import com.sulake.bootstrap.ModerationManagerBootstrap;
   import com.sulake.iid.IIDHabboModeration;
   import mx.core.SimpleApplication;
   
   [SecureSWF(rename="false")]
   public class HabboModerationCom extends SimpleApplication
   {
      public static var manifest:Class = manifest_7_xml;
      
      public static var requiredClasses:Array = new Array(ModerationManagerBootstrap,IIDHabboModeration);
      
      public static var evidence_frame_xml:Class = evidence_frame_1_xml;
      
      public static var issue_browser_xml:Class = issue_browser_1_xml;
      
      public static var modact_summary_xml:Class = modact_summary_1_xml;
      
      public static var new_moderation_tool_xml:Class = new_moderation_tool_1_xml;
      
      public static var send_msgs_xml:Class = send_msgs_1_xml;
      
      public static var start_panel_xml:Class = start_panel_1_xml;
      
      public static var user_info_xml:Class = user_info_1_xml;
      
      public static var user_info_frame_xml:Class = user_info_frame_1_xml;
      
      public static var issue_handler_xml:Class = issue_handler_1_xml;
      
      public static var roomtool_frame_xml:Class = roomtool_frame_1_xml;
      
      public static var roomvisits_frame_xml:Class = roomvisits_frame_1_xml;
      
      public static var userclassification_frame_xml:Class = userclassification_frame_1_xml;
      
      public static var room_icon_png:Class = room_icon_1_png;
      
      public static var user_icon_png:Class = user_icon_1_png;
      
      public function HabboModerationCom()
      {
         super();
      }
   }
}

