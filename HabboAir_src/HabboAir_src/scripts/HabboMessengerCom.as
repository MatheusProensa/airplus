package
{
   import com.sulake.bootstrap.HabboMessengerBootstrap;
   import com.sulake.iid.IIDHabboMessenger;
   import mx.core.SimpleApplication;
   
   [SecureSWF(rename="false")]
   public class HabboMessengerCom extends SimpleApplication
   {
      public static var manifest:Class = manifest_1_xml;
      
      public static var close_png:Class = close_2_png;
      
      public static var convo_bg_png:Class = convo_bg_1_png;
      
      public static var follow_friend_png:Class = follow_friend_1_png;
      
      public static var minimail_png:Class = minimail_1_png;
      
      public static var next_png:Class = next_3_png;
      
      public static var prev_png:Class = prev_1_png;
      
      public static var resize_png:Class = resize_1_png;
      
      public static var tab_bg_hilite_png:Class = tab_bg_hilite_1_png;
      
      public static var tab_bg_next_png:Class = tab_bg_next_1_png;
      
      public static var tab_bg_sel_png:Class = tab_bg_sel_1_png;
      
      public static var tab_bg_unsel_png:Class = tab_bg_unsel_1_png;
      
      public static var main_window_xml:Class = main_window_2_xml;
      
      public static var msg_entry_xml:Class = msg_entry_1_xml;
      
      public static var tab_entry_xml:Class = tab_entry_1_xml;
      
      public static var messenger_xml:Class = messenger_1_xml;
      
      public static var messenger_habbicon_picker_xml:Class = messenger_habbicon_picker_1_xml;
      
      public static var requiredClasses:Array = new Array(HabboMessengerBootstrap,IIDHabboMessenger);
      
      public function HabboMessengerCom()
      {
         super();
      }
   }
}

