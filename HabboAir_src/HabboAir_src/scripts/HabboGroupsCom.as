package
{
   import com.sulake.bootstrap.HabboGroupsManagerBootstrap;
   import com.sulake.iid.IIDHabboGroupsManager;
   import mx.core.SimpleApplication;
   
   [SecureSWF(rename="false")]
   public class HabboGroupsCom extends SimpleApplication
   {
      public static var manifest:Class = manifest_12_xml;
      
      public static var group:Class = group_1_xml;
      
      public static var guild_members_window:Class = guild_members_window_1_xml;
      
      public static var group_entry:Class = group_entry_1_xml;
      
      public static var member_entry:Class = member_entry_1_xml;
      
      public static var group_info_window:Class = group_info_window_1_xml;
      
      public static var group_management_window:Class = group_management_window_1_xml;
      
      public static var new_extended_profile:Class = new_extended_profile_1_xml;
      
      public static var club_required:Class = club_required_1_xml;
      
      public static var group_created_window:Class = group_created_window_1_xml;
      
      public static var group_room_info:Class = group_room_info_1_xml;
      
      public static var no_groups:Class = no_groups_1_xml;
      
      public static var extended_profile_badge_details:Class = extended_profile_badge_details_1_xml;
      
      public static var badge_color_item:Class = badge_color_item_1_xml;
      
      public static var badge_editor:Class = badge_editor_1_xml;
      
      public static var badge_layer:Class = badge_layer_1_xml;
      
      public static var badge_part_item:Class = badge_part_item_1_xml;
      
      public static var badge_leaderboard_view:Class = main_view_2_xml;
      
      public static var color_chooser_bg:Class = color_chooser_bg_1_png;
      
      public static var color_chooser_fg:Class = color_chooser_fg_1_png;
      
      public static var color_chooser_selected:Class = color_chooser_selected_1_png;
      
      public static var part_preview_bg:Class = part_preview_bg_1_png;
      
      public static var position_grid:Class = position_grid_1_png;
      
      public static var position_picker:Class = position_picker_1_png;
      
      public static var badge_part_add:Class = badge_part_add_1_png;
      
      public static var badge_part_empty:Class = badge_part_empty_1_png;
      
      public static var badge_part_picker:Class = badge_part_picker_1_png;
      
      public static var requiredClasses:Array = new Array(HabboGroupsManagerBootstrap,IIDHabboGroupsManager);
      
      public function HabboGroupsCom()
      {
         super();
      }
   }
}

