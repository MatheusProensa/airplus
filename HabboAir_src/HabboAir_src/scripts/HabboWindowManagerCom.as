package
{
   import com.sulake.bootstrap.HabboWindowManagerComponentBootstrap;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import com.sulake.iid.IIDCoreWindowManager;
   import com.sulake.iid.IIDHabboWindowManager;
   import mx.core.SimpleApplication;
   
   [SecureSWF(rename="false")]
   public class HabboWindowManagerCom extends SimpleApplication
   {
      public static var requiredClasses:Array = new Array(HabboWindowManagerComponentBootstrap,IIDHabboWindowManager,IIDCoreWindowManager,HabboWindowManagerComponent,ICoreLocalizationFrameworkLib,ICoreWindowFrameworkLib,CoreWindowFrameworkLib);
      
      public static var manifest:Class = manifest_18_xml;
      
      public static var habbo_element_description_xml:Class = habbo_element_description_1_xml;
      
      public static var habbo_window_layout_alert_xml:Class = alert_1_xml;
      
      public static var habbo_window_layout_bubble_xml:Class = bubble_1_xml;
      
      public static var habbo_window_layout_bubble_7_xml:Class = bubble_7_1_xml;
      
      public static var habbo_window_layout_button_xml:Class = button_1_xml;
      
      public static var habbo_window_layout_button_thick_xml:Class = button_thick_1_xml;
      
      public static var habbo_window_layout_button_black_xml:Class = button_black_1_xml;
      
      public static var habbo_window_layout_button_thick_black_xml:Class = button_thick_black_1_xml;
      
      public static var habbo_window_layout_button_shiny_xml:Class = button_shiny_1_xml;
      
      public static var habbo_window_layout_button_shiny_thick_xml:Class = button_shiny_thick_1_xml;
      
      public static var habbo_window_layout_button_shiny_large_xml:Class = button_shiny_large_1_xml;
      
      public static var habbo_window_layout_button_shiny_large_5_xml:Class = button_shiny_large_5_1_xml;
      
      public static var habbo_window_layout_button_shiny_black_xml:Class = button_shiny_black_1_xml;
      
      public static var habbo_window_layout_button_shiny_thick_black_xml:Class = button_shiny_thick_black_1_xml;
      
      public static var habbo_window_layout_dropmenu_xml:Class = dropmenu_1_xml;
      
      public static var habbo_window_layout_dropmenu_3_xml:Class = dropmenu_3_1_xml;
      
      public static var habbo_window_layout_dropmenu_black_xml:Class = dropmenu_black_1_xml;
      
      public static var habbo_window_layout_dropmenu_item_xml:Class = dropmenu_item_1_xml;
      
      public static var habbo_window_layout_dropmenu_item_3_xml:Class = dropmenu_item_3_1_xml;
      
      public static var habbo_window_layout_dropmenu_item_black_xml:Class = dropmenu_item_black_1_xml;
      
      public static var habbo_window_layout_droplist_xml:Class = droplist_1_xml;
      
      public static var habbo_window_layout_frame_xml:Class = frame_1_xml;
      
      public static var habbo_window_layout_frame_3_xml:Class = frame_3_1_xml;
      
      public static var habbo_window_layout_frame_7_xml:Class = frame_7_1_xml;
      
      public static var habbo_window_layout_frame_leaderboard_xml:Class = frame_leaderboard_1_xml;
      
      public static var habbo_window_layout_header_xml:Class = header_1_xml;
      
      public static var habbo_window_layout_header_black_xml:Class = header_black_1_xml;
      
      public static var habbo_window_layout_header_3_xml:Class = header_3_1_xml;
      
      public static var habbo_window_layout_header_7_xml:Class = header_7_1_xml;
      
      public static var habbo_window_layout_header_leaderboard_xml:Class = header_leaderboard_1_xml;
      
      public static var habbo_window_layout_scaler_xml:Class = scaler_1_xml;
      
      public static var habbo_window_layout_scaler_3_xml:Class = scaler_3_1_xml;
      
      public static var habbo_window_layout_scrollbar_horizontal_xml:Class = scrollbar_horizontal_1_xml;
      
      public static var habbo_window_layout_scrollbar_vertical_xml:Class = scrollbar_vertical_1_xml;
      
      public static var habbo_window_layout_scrollable_itemlist_vertical_xml:Class = scrollable_itemlist_vertical_1_xml;
      
      public static var habbo_window_layout_scrollable_itemgrid_vertical_xml:Class = scrollable_itemgrid_vertical_1_xml;
      
      public static var habbo_window_layout_scrollable_itemlist_vertical_ubuntu_xml:Class = scrollable_itemlist_vertical_ubuntu_1_xml;
      
      public static var habbo_window_layout_scrollable_itemgrid_vertical_ubuntu_xml:Class = scrollable_itemgrid_vertical_ubuntu_1_xml;
      
      public static var habbo_window_layout_simple_xml:Class = simple_1_xml;
      
      public static var habbo_window_layout_tab_button_xml:Class = tab_button_1_xml;
      
      public static var habbo_window_layout_tab_button_black_xml:Class = tab_button_black_1_xml;
      
      public static var habbo_window_layout_tab_button_3_xml:Class = tab_button_3_1_xml;
      
      public static var habbo_window_layout_tab_context_xml:Class = tab_context_1_xml;
      
      public static var habbo_window_layout_tab_context_3_xml:Class = tab_context_3_1_xml;
      
      public static var habbo_window_layout_tooltip_xml:Class = tooltip_1_xml;
      
      public static var habbo_skin_frame_xml:Class = habbo_skin_frame_1_xml;
      
      public static var habbo_skin_frame_3_xml:Class = habbo_skin_frame_3_1_xml;
      
      public static var habbo_skin_frame_7_xml:Class = habbo_skin_frame_7_1_xml;
      
      public static var habbo_skin_frame_leaderboard_all_xml:Class = habbo_skin_frame_leaderboard_all_1_xml;
      
      public static var habbo_skin_frame_leaderboard_ach_xml:Class = habbo_skin_frame_leaderboard_ach_1_xml;
      
      public static var habbo_skin_frame_leaderboard_rarity_uncommon_xml:Class = habbo_skin_frame_leaderboard_rarity_uncommon_1_xml;
      
      public static var habbo_skin_frame_leaderboard_rarity_1_xml:Class = habbo_skin_frame_leaderboard_rarity_1_1_xml;
      
      public static var habbo_skin_frame_leaderboard_rarity_2_xml:Class = habbo_skin_frame_leaderboard_rarity_2_1_xml;
      
      public static var habbo_skin_frame_leaderboard_rarity_3_xml:Class = habbo_skin_frame_leaderboard_rarity_3_1_xml;
      
      public static var habbo_skin_frame_leaderboard_rarity_4_xml:Class = habbo_skin_frame_leaderboard_rarity_4_1_xml;
      
      public static var habbo_skin_frame_leaderboard_rarity_5_xml:Class = habbo_skin_frame_leaderboard_rarity_5_1_xml;
      
      public static var habbo_skin_bubble_xml:Class = habbo_skin_bubble_1_xml;
      
      public static var habbo_skin_bubble_pointer_up_xml:Class = habbo_skin_bubble_pointer_up_1_xml;
      
      public static var habbo_skin_bubble_pointer_right_xml:Class = habbo_skin_bubble_pointer_right_1_xml;
      
      public static var habbo_skin_bubble_pointer_down_xml:Class = habbo_skin_bubble_pointer_down_1_xml;
      
      public static var habbo_skin_frame_pointer_down_xml:Class = habbo_skin_frame_pointer_down_1_xml;
      
      public static var habbo_skin_bubble_pointer_left_xml:Class = habbo_skin_bubble_pointer_left_1_xml;
      
      public static var habbo_skin_bubble_7_xml:Class = habbo_skin_bubble_7_1_xml;
      
      public static var habbo_skin_bubble_pointer_up_7_xml:Class = habbo_skin_bubble_pointer_up_7_1_xml;
      
      public static var habbo_skin_bubble_pointer_right_7_xml:Class = habbo_skin_bubble_pointer_right_7_1_xml;
      
      public static var habbo_skin_bubble_pointer_down_7_xml:Class = habbo_skin_bubble_pointer_down_7_1_xml;
      
      public static var habbo_skin_bubble_pointer_left_7_xml:Class = habbo_skin_bubble_pointer_left_7_1_xml;
      
      public static var habbo_skin_button_default_xml:Class = habbo_skin_button_default_1_xml;
      
      public static var habbo_skin_button_default_black_xml:Class = habbo_skin_button_default_black_1_xml;
      
      public static var habbo_skin_button_default_white_xml:Class = habbo_skin_button_default_white_1_xml;
      
      public static var habbo_skin_button_shiny_default_xml:Class = habbo_skin_button_shiny_default_1_xml;
      
      public static var habbo_skin_button_shiny_black_xml:Class = habbo_skin_button_shiny_black_1_xml;
      
      public static var habbo_skin_button_shiny_thick_xml:Class = habbo_skin_button_shiny_thick_1_xml;
      
      public static var habbo_skin_button_shiny_large_xml:Class = habbo_skin_button_shiny_large_1_xml;
      
      public static var habbo_skin_button_shiny_thick_black_xml:Class = habbo_skin_button_shiny_thick_black_1_xml;
      
      public static var habbo_skin_button_thick_xml:Class = habbo_skin_button_thick_1_xml;
      
      public static var habbo_skin_button_thick_black_xml:Class = habbo_skin_button_thick_black_1_xml;
      
      public static var habbo_skin_button_thick_white_xml:Class = habbo_skin_button_thick_white_1_xml;
      
      public static var habbo_skin_button_group_left_xml:Class = habbo_skin_button_group_left_1_xml;
      
      public static var habbo_skin_button_group_left_black_xml:Class = habbo_skin_button_group_left_black_1_xml;
      
      public static var habbo_skin_button_group_left_white_xml:Class = habbo_skin_button_group_left_white_1_xml;
      
      public static var habbo_skin_button_group_center_xml:Class = habbo_skin_button_group_center_1_xml;
      
      public static var habbo_skin_button_group_center_black_xml:Class = habbo_skin_button_group_center_black_1_xml;
      
      public static var habbo_skin_button_group_center_white_xml:Class = habbo_skin_button_group_center_white_1_xml;
      
      public static var habbo_skin_button_group_right_xml:Class = habbo_skin_button_group_right_1_xml;
      
      public static var habbo_skin_button_group_right_black_xml:Class = habbo_skin_button_group_right_black_1_xml;
      
      public static var habbo_skin_button_group_right_white_xml:Class = habbo_skin_button_group_right_white_1_xml;
      
      public static var habbo_skin_button_checkbox_xml:Class = habbo_skin_button_checkbox_1_xml;
      
      public static var habbo_skin_button_checkbox_black_xml:Class = habbo_skin_button_checkbox_black_1_xml;
      
      public static var habbo_skin_button_checkbox_white_xml:Class = habbo_skin_button_checkbox_white_1_xml;
      
      public static var habbo_skin_button_close_xml:Class = habbo_skin_button_close_1_xml;
      
      public static var habbo_skin_button_close_black_xml:Class = habbo_skin_button_close_black_1_xml;
      
      public static var habbo_skin_button_close_white_xml:Class = habbo_skin_button_close_white_1_xml;
      
      public static var habbo_skin_button_close_3_xml:Class = habbo_skin_button_close_3_1_xml;
      
      public static var habbo_skin_button_close_leaderboard_xml:Class = habbo_skin_button_close_leaderboard_1_xml;
      
      public static var habbo_skin_button_plus_3_xml:Class = habbo_skin_button_plus_3_1_xml;
      
      public static var habbo_skin_button_minus_3_xml:Class = habbo_skin_button_minus_3_1_xml;
      
      public static var habbo_skin_button_help_3_xml:Class = habbo_skin_button_help_3_1_xml;
      
      public static var habbo_skin_button_menu_xml:Class = habbo_skin_button_menu_1_xml;
      
      public static var habbo_skin_button_radio_xml:Class = habbo_skin_button_radio_1_xml;
      
      public static var habbo_skin_button_radio_black_xml:Class = habbo_skin_button_radio_black_1_xml;
      
      public static var habbo_skin_button_radio_white_xml:Class = habbo_skin_button_radio_white_1_xml;
      
      public static var habbo_skin_button_tab_xml:Class = habbo_skin_button_tab_1_xml;
      
      public static var habbo_skin_button_tab_black_xml:Class = habbo_skin_button_tab_black_1_xml;
      
      public static var habbo_skin_button_tab_white_xml:Class = habbo_skin_button_tab_white_1_xml;
      
      public static var habbo_skin_button_tab_3_xml:Class = habbo_skin_button_tab_3_1_xml;
      
      public static var habbo_skin_tab_content_3_xml:Class = habbo_skin_tab_content_3_1_xml;
      
      public static var habbo_skin_scaler_xml:Class = habbo_skin_scaler_1_xml;
      
      public static var habbo_skin_scaler_black_xml:Class = habbo_skin_scaler_black_1_xml;
      
      public static var habbo_skin_scaler_white_xml:Class = habbo_skin_scaler_white_1_xml;
      
      public static var habbo_skin_scaler_3_xml:Class = habbo_skin_scaler_3_1_xml;
      
      public static var habbo_skin_scrollbar_xml:Class = habbo_skin_scrollbar_1_xml;
      
      public static var habbo_skin_scrollbar_black_xml:Class = habbo_skin_scrollbar_black_1_xml;
      
      public static var habbo_skin_scrollbar_3_xml:Class = habbo_skin_scrollbar_3_1_xml;
      
      public static var habbo_skin_header_xml:Class = habbo_skin_header_1_xml;
      
      public static var habbo_skin_header_3_xml:Class = habbo_skin_header_3_1_xml;
      
      public static var habbo_skin_header_7_xml:Class = habbo_skin_header_7_1_xml;
      
      public static var habbo_skin_header_leaderboard_xml:Class = habbo_skin_header_leaderboard_1_xml;
      
      public static var habbo_skin_icon_set_xml:Class = habbo_skin_icon_set_1_xml;
      
      public static var habbo_skin_dropmenu_xml:Class = habbo_skin_dropmenu_1_xml;
      
      public static var habbo_skin_dropmenu_3_xml:Class = habbo_skin_dropmenu_3_1_xml;
      
      public static var habbo_skin_dropmenu_black_xml:Class = habbo_skin_dropmenu_black_1_xml;
      
      public static var habbo_skin_droplist_xml:Class = habbo_skin_droplist_1_xml;
      
      public static var habbo_skin_droplist_thick_xml:Class = habbo_skin_droplist_thick_1_xml;
      
      public static var habbo_skin_tab_context_xml:Class = habbo_skin_tab_context_1_xml;
      
      public static var habbo_skin_border_black_xml:Class = habbo_skin_border_black_1_xml;
      
      public static var habbo_skin_border_colorless_xml:Class = habbo_skin_border_colorless_1_xml;
      
      public static var habbo_skin_border_colorless_dropshadow_xml:Class = habbo_skin_border_colorless_dropshadow_1_xml;
      
      public static var habbo_skin_border_white_xml:Class = habbo_skin_border_white_1_xml;
      
      public static var habbo_skin_border_slot_xml:Class = habbo_skin_border_slot_1_xml;
      
      public static var habbo_skin_border_slot_2_xml:Class = habbo_skin_border_slot_2_1_xml;
      
      public static var habbo_skin_border_4_xml:Class = habbo_skin_border_4_1_xml;
      
      public static var habbo_skin_border_5_xml:Class = habbo_skin_border_5_1_xml;
      
      public static var habbo_skin_border_6_xml:Class = habbo_skin_border_6_1_xml;
      
      public static var habbo_skin_border_7_xml:Class = habbo_skin_border_7_1_xml;
      
      public static var habbo_skin_border_8_xml:Class = habbo_skin_border_8_1_xml;
      
      public static var habbo_skin_border_9_xml:Class = habbo_skin_border_9_1_xml;
      
      public static var habbo_skin_border_12_xml:Class = habbo_skin_border_12_1_xml;
      
      public static var habbo_skin_border_13_xml:Class = habbo_skin_border_13_1_xml;
      
      public static var habbo_skin_border_14_xml:Class = habbo_skin_border_14_1_xml;
      
      public static var habbo_skin_border_15_xml:Class = habbo_skin_border_15_1_xml;
      
      public static var habbo_skin_border_16_xml:Class = habbo_skin_border_16_1_xml;
      
      public static var habbo_skin_text_xml:Class = habbo_skin_text_1_xml;
      
      public static var habbo_skin_tooltip_xml:Class = habbo_skin_tooltip_1_xml;
      
      public static var text_styles_css:Class = styles_1_css;
      
      public static var habbo_blue_skin_png:Class = habbo_skin_blue_1_png;
      
      public static var habbo_skin_ubuntu_png:Class = habbo_skin_ubuntu_1_png;
      
      public static var habbo_border_hsv_layers_png:Class = habbo_border_hsv_layers_1_png;
      
      public static var habbo_border_hsv_layers2_png:Class = habbo_border_hsv_layers2_1_png;
      
      public static var skin_ubuntu_bg_9:Class = ubuntu_bg_9_1_png;
      
      public static var ubuntu_frame_leaderboard_all_png:Class = ubuntu_frame_leaderboard_all_1_png;
      
      public static var ubuntu_frame_leaderboard_ach_png:Class = ubuntu_frame_leaderboard_ach_1_png;
      
      public static var ubuntu_frame_leaderboard_rarity_uncommon_png:Class = ubuntu_frame_leaderboard_rarity_uncommon_1_png;
      
      public static var ubuntu_frame_leaderboard_rarity_1_png:Class = ubuntu_frame_leaderboard_rarity_1_1_png;
      
      public static var ubuntu_frame_leaderboard_rarity_2_png:Class = ubuntu_frame_leaderboard_rarity_2_1_png;
      
      public static var ubuntu_frame_leaderboard_rarity_3_png:Class = ubuntu_frame_leaderboard_rarity_3_1_png;
      
      public static var ubuntu_frame_leaderboard_rarity_4_png:Class = ubuntu_frame_leaderboard_rarity_4_1_png;
      
      public static var ubuntu_frame_leaderboard_rarity_5_png:Class = ubuntu_frame_leaderboard_rarity_5_1_png;
      
      public static var leaderboard_button_close_png:Class = leaderboard_button_close_1_png;
      
      public static var habbo_cursor_link_png:Class = habbo_cursor_link_1_png;
      
      public static var habbo_cursor_drag_png:Class = habbo_cursor_drag_1_png;
      
      public static var habbo_icons_png:Class = habbo_icons_1_png;
      
      public static var placeholder_avatar_png:Class = placeholder_avatar_1_png;
      
      public static var placeholder_avatar_head_png:Class = placeholder_avatar_head_1_png;
      
      public static var placeholder_avatar_cropped_png:Class = placeholder_avatar_cropped_1_png;
      
      public static var placeholder_avatar_head_cropped_png:Class = placeholder_avatar_head_cropped_1_png;
      
      public static var placeholder_avatar_small_png:Class = placeholder_avatar_small_1_png;
      
      public static var placeholder_avatar_small_head_png:Class = placeholder_avatar_small_head_1_png;
      
      public static var placeholder_avatar_small_cropped_png:Class = placeholder_avatar_small_cropped_1_png;
      
      public static var placeholder_avatar_small_head_cropped_png:Class = placeholder_avatar_small_head_cropped_1_png;
      
      public static var placeholder_pet_png:Class = placeholder_pet_1_png;
      
      public static var placeholder_pet_small_png:Class = placeholder_pet_small_1_png;
      
      public static var placeholder_furni_png:Class = placeholder_furni_1_png;
      
      public static var placeholder_furni_small_png:Class = placeholder_furni_small_1_png;
      
      public static var sticker_croco:Class = sticker_croco_1_png;
      
      public static var volter:Class = Volter_latin2_baseline_1_ttf;
      
      public static var volterb:Class = Volter_Bol_1_ttf;
      
      public static var ubuntu_regular:Class = §Ubuntu-R_2_ttf§;
      
      public static var ubuntu_bold:Class = §Ubuntu-B_3_ttf§;
      
      public static var ubuntu_condensed:Class = §Ubuntu-C_1_ttf§;
      
      public static var ubuntuThick_bold:Class = §UbuntuThick-Bold_1_ttf§;
      
      public static var ubuntu_italic:Class = §Ubuntu-I_2_ttf§;
      
      public static var ubuntu_bold_italic:Class = §Ubuntu-BI_2_ttf§;
      
      public static var ubuntuMedium:Class = §Ubuntu-M_1_ttf§;
      
      public static var habbo_window_alert_xml:Class = habbo_window_alert_1_xml;
      
      public static var habbo_window_alert_link_xml:Class = habbo_window_alert_link_1_xml;
      
      public static var habbo_window_confirm_xml:Class = habbo_window_confirm_1_xml;
      
      public static var habbo_crasher_dialog_xml:Class = habbo_crasher_dialog_1_xml;
      
      public static var unseen_item_counter_xml:Class = unseen_item_counter_1_xml;
      
      public static var simple_alert_xml:Class = simple_alert_2_xml;
      
      public static var illumina_alert_illustrations_frank_neutral_png:Class = frank_neutral_1_png;
      
      public static var habbo_skin_illumina_light_png:Class = habbo_skin_illumina_light_1_png;
      
      public static var illumina_light_balloon_png:Class = illumina_light_balloon_1_png;
      
      public static var illumina_light_border_etched_png:Class = illumina_light_border_etched_1_png;
      
      public static var illumina_light_border_frame_png:Class = illumina_light_border_frame_1_png;
      
      public static var illumina_light_border_infobox_png:Class = illumina_light_border_infobox_1_png;
      
      public static var illumina_light_border_light_png:Class = illumina_light_border_light_1_png;
      
      public static var illumina_light_border_raised_png:Class = illumina_light_border_raised_1_png;
      
      public static var illumina_light_border_sunk_png:Class = illumina_light_border_sunk_1_png;
      
      public static var illumina_light_bubble_chat_arrow_png:Class = illumina_light_bubble_chat_arrow_1_png;
      
      public static var illumina_light_bubble_chat_bg_png:Class = illumina_light_bubble_chat_bg_1_png;
      
      public static var illumina_light_button_default_png:Class = illumina_light_button_default_1_png;
      
      public static var illumina_light_button_multi_png:Class = illumina_light_button_multi_1_png;
      
      public static var illumina_light_button_frame_close_png:Class = illumina_light_button_frame_close_1_png;
      
      public static var illumina_light_button_frame_menu_png:Class = illumina_light_button_frame_menu_1_png;
      
      public static var illumina_light_button_frame_minimize_png:Class = illumina_light_button_frame_minimize_1_png;
      
      public static var illumina_light_button_unetched_png:Class = illumina_light_button_unetched_1_png;
      
      public static var illumina_light_button_dark_recolorable_png:Class = illumina_light_button_dark_recolorable_1_png;
      
      public static var illumina_light_checkbox_basic_png:Class = illumina_light_checkbox_basic_1_png;
      
      public static var illumina_light_clock_background_png:Class = illumina_light_clock_background_1_png;
      
      public static var illumina_light_clock_background_left_png:Class = illumina_light_clock_background_left_1_png;
      
      public static var illumina_light_clock_background_mid_png:Class = illumina_light_clock_background_mid_1_png;
      
      public static var illumina_light_clock_background_right_png:Class = illumina_light_clock_background_right_1_png;
      
      public static var illumina_light_icons_png:Class = illumina_light_icons_1_png;
      
      public static var illumina_light_input_chat_png:Class = illumina_light_input_chat_1_png;
      
      public static var illumina_light_progress_indicator_etched_png:Class = illumina_light_progress_indicator_etched_1_png;
      
      public static var illumina_light_progress_indicator_flat_png:Class = illumina_light_progress_indicator_flat_1_png;
      
      public static var illumina_light_radio_button_png:Class = illumina_light_radio_button_1_png;
      
      public static var illumina_light_scrollbar_horizontal_png:Class = illumina_light_scrollbar_horizontal_1_png;
      
      public static var illumina_light_scrollbar_vertical_png:Class = illumina_light_scrollbar_vertical_1_png;
      
      public static var illumina_light_separator_png:Class = illumina_light_separator_1_png;
      
      public static var illumina_light_switch_png:Class = illumina_light_switch_1_png;
      
      public static var illumina_light_skin_border_xml:Class = illumina_light_skin_border_1_xml;
      
      public static var illumina_light_skin_border_sunk_xml:Class = illumina_light_skin_border_sunk_1_xml;
      
      public static var illumina_light_skin_border_light_xml:Class = illumina_light_skin_border_light_1_xml;
      
      public static var illumina_light_skin_border_raised_xml:Class = illumina_light_skin_border_raised_1_xml;
      
      public static var illumina_light_skin_border_input_xml:Class = illumina_light_skin_border_input_1_xml;
      
      public static var illumina_light_skin_border_chat_bubble_xml:Class = illumina_light_skin_border_chat_bubble_1_xml;
      
      public static var illumina_light_skin_border_balloon_xml:Class = illumina_light_skin_border_balloon_1_xml;
      
      public static var illumina_light_skin_border_infobox_xml:Class = illumina_light_skin_border_infobox_1_xml;
      
      public static var illumina_light_frame_xml:Class = illumina_light_frame_1_xml;
      
      public static var illumina_light_frame_modal_xml:Class = illumina_light_frame_modal_1_xml;
      
      public static var illumina_light_frame_wired_xml:Class = illumina_light_frame_wired_1_xml;
      
      public static var illumina_light_skin_frame_xml:Class = illumina_light_skin_frame_1_xml;
      
      public static var illumina_light_skin_button_frame_close_xml:Class = illumina_light_skin_button_frame_close_1_xml;
      
      public static var illumina_light_skin_button_frame_menu_xml:Class = illumina_light_skin_button_frame_menu_1_xml;
      
      public static var illumina_light_skin_button_frame_minimize_xml:Class = illumina_light_skin_button_frame_minimize_1_xml;
      
      public static var illumina_light_button_xml:Class = illumina_light_button_1_xml;
      
      public static var illumina_light_button_plain_xml:Class = illumina_light_button_plain_1_xml;
      
      public static var illumina_light_skin_button_xml:Class = illumina_light_skin_button_1_xml;
      
      public static var illumina_light_skin_button_plain_xml:Class = illumina_light_skin_button_plain_1_xml;
      
      public static var illumina_light_skin_button_multi_left_xml:Class = illumina_light_skin_button_multi_left_1_xml;
      
      public static var illumina_light_skin_button_multi_right_xml:Class = illumina_light_skin_button_multi_right_1_xml;
      
      public static var illumina_light_skin_button_multi_middle_xml:Class = illumina_light_skin_button_multi_middle_1_xml;
      
      public static var illumina_light_skin_button_unetched_xml:Class = illumina_light_skin_button_unetched_1_xml;
      
      public static var illumina_light_skin_button_dark_recolorable_xml:Class = illumina_light_skin_button_dark_recolorable_1_xml;
      
      public static var illumina_light_checkbox_basic_xml:Class = illumina_light_checkbox_basic_1_xml;
      
      public static var illumina_light_skin_checkbox_basic_xml:Class = illumina_light_skin_checkbox_basic_1_xml;
      
      public static var illumina_light_skin_dropmenu_xml:Class = illumina_light_skin_dropmenu_1_xml;
      
      public static var illumina_light_switch_xml:Class = illumina_light_switch_1_xml;
      
      public static var illumina_light_skin_switch_xml:Class = illumina_light_skin_switch_1_xml;
      
      public static var illumina_light_radio_button_xml:Class = illumina_light_radio_button_1_xml;
      
      public static var illumina_light_skin_radio_button_xml:Class = illumina_light_skin_radio_button_1_xml;
      
      public static var illumina_light_scrollbar_horizontal_xml:Class = illumina_light_scrollbar_horizontal_1_xml;
      
      public static var illumina_light_scrollbar_vertical_xml:Class = illumina_light_scrollbar_vertical_1_xml;
      
      public static var illumina_light_skin_scrollbar_xml:Class = illumina_light_skin_scrollbar_1_xml;
      
      public static var illumina_light_scrollable_itemlist_vertical_xml:Class = illumina_light_scrollable_itemlist_vertical_1_xml;
      
      public static var illumina_light_dropmenu_item_xml:Class = illumina_light_dropmenu_item_1_xml;
      
      public static var illumina_light_dropmenu_xml:Class = illumina_light_dropmenu_1_xml;
      
      public static var illumina_purple_border_frame_png:Class = illumina_purple_border_frame_1_png;
      
      public static var illumina_purple_button_frame_close_png:Class = illumina_purple_button_frame_close_1_png;
      
      public static var illumina_purple_button_default_png:Class = illumina_purple_button_default_1_png;
      
      public static var illumina_purple_skin_frame_xml:Class = illumina_purple_skin_frame_1_xml;
      
      public static var illumina_purple_skin_button_frame_close_xml:Class = illumina_purple_skin_button_frame_close_1_xml;
      
      public static var illumina_purple_frame_xml:Class = illumina_purple_frame_1_xml;
      
      public static var illumina_purple_button_xml:Class = illumina_purple_button_1_xml;
      
      public static var illumina_purple_button_plain_xml:Class = illumina_purple_button_plain_1_xml;
      
      public static var illumina_purple_skin_button_xml:Class = illumina_purple_skin_button_1_xml;
      
      public static var illumina_purple_skin_button_plain_xml:Class = illumina_purple_skin_button_plain_1_xml;
      
      public static var habbo_skin_illumina_dark_png:Class = habbo_skin_illumina_dark_1_png;
      
      public static var illumina_dark_skin_border_xml:Class = illumina_dark_skin_border_1_xml;
      
      public static var illumina_dark_frame_xml:Class = illumina_dark_frame_1_xml;
      
      public static var illumina_dark_skin_frame_xml:Class = illumina_dark_skin_frame_1_xml;
      
      public static var illumina_dark_header_xml:Class = illumina_dark_header_1_xml;
      
      public static var illumina_dark_skin_header_xml:Class = illumina_dark_skin_header_1_xml;
      
      public static var illumina_dark_button_xml:Class = illumina_dark_button_1_xml;
      
      public static var illumina_dark_skin_button_xml:Class = illumina_dark_skin_button_1_xml;
      
      public static var illumina_dark_scrollbar_horizontal_xml:Class = illumina_dark_scrollbar_horizontal_1_xml;
      
      public static var illumina_dark_scrollbar_vertical_xml:Class = illumina_dark_scrollbar_vertical_1_xml;
      
      public static var illumina_dark_skin_scrollbar_xml:Class = illumina_dark_skin_scrollbar_1_xml;
      
      public static var illumina_dark_scrollbar_horizontal_png:Class = illumina_dark_scrollbar_horizontal_1_png;
      
      public static var illumina_dark_scrollbar_vertical_png:Class = illumina_dark_scrollbar_vertical_1_png;
      
      public static var achievement_ach_progressbar1:Class = ach_progressbar1_1_png;
      
      public static var achievement_ach_progressbar2:Class = ach_progressbar2_1_png;
      
      public static var achievement_ach_progressbar3:Class = ach_progressbar3_1_png;
      
      public static var achievement_ach_progressbar4:Class = ach_progressbar4_1_png;
      
      public static var achievement_ach_progressbar5:Class = ach_progressbar5_1_png;
      
      public static var avatar_editor_avatar_editor_download_icon:Class = avatar_editor_download_icon_1_png;
      
      public static var avatar_editor_editor_clr_13x21_1:Class = editor_clr_13x21_1_1_png;
      
      public static var avatar_editor_editor_clr_13x21_2:Class = editor_clr_13x21_2_1_png;
      
      public static var avatar_editor_editor_clr_13x21_3:Class = editor_clr_13x21_3_1_png;
      
      public static var avatar_editor_editor_clr_40x32_1:Class = editor_clr_40x32_1_1_png;
      
      public static var avatar_editor_editor_clr_40x32_2:Class = editor_clr_40x32_2_1_png;
      
      public static var avatar_editor_editor_clr_40x32_3:Class = editor_clr_40x32_3_1_png;
      
      public static var avatar_editor_generic_platform:Class = platform_1_png;
      
      public static var avatar_editor_generic_remove_selection:Class = remove_selection_1_png;
      
      public static var avatar_editor_parts_hilite:Class = parts_hilite_1_png;
      
      public static var avatar_editor_parts_hilite_with_sd:Class = parts_hilite_with_sd_1_png;
      
      public static var avatar_editor_rotate_avatar_button:Class = rotate_avatar_button_1_png;
      
      public static var avatar_editor_tabs_ae_tabs_effects:Class = ae_tabs_effects_1_png;
      
      public static var avatar_editor_tabs_ae_tabs_generic:Class = ae_tabs_generic_1_png;
      
      public static var avatar_editor_tabs_ae_tabs_head:Class = ae_tabs_head_1_png;
      
      public static var avatar_editor_tabs_ae_tabs_hotlooks:Class = ae_tabs_hotlooks_1_png;
      
      public static var avatar_editor_tabs_ae_tabs_legs:Class = ae_tabs_legs_1_png;
      
      public static var avatar_editor_tabs_ae_tabs_misc:Class = ae_tabs_misc_1_png;
      
      public static var avatar_editor_tabs_ae_tabs_torso:Class = ae_tabs_torso_1_png;
      
      public static var avatar_editor_tabs_ae_tabs_wardrobe:Class = ae_tabs_wardrobe_1_png;
      
      public static var avatar_editor_tabs_bottom_accessories:Class = bottom_accessories_1_png;
      
      public static var avatar_editor_tabs_bottom_accessories_off:Class = bottom_accessories_off_1_png;
      
      public static var avatar_editor_tabs_bottom_shoes:Class = bottom_shoes_1_png;
      
      public static var avatar_editor_tabs_bottom_shoes_off:Class = bottom_shoes_off_1_png;
      
      public static var avatar_editor_tabs_bottom_trousers:Class = bottom_trousers_1_png;
      
      public static var avatar_editor_tabs_bottom_trousers_off:Class = bottom_trousers_off_1_png;
      
      public static var avatar_editor_tabs_effects_fx:Class = effects_fx_1_png;
      
      public static var avatar_editor_tabs_gender_female:Class = gender_female_1_png;
      
      public static var avatar_editor_tabs_gender_female_off:Class = gender_female_off_1_png;
      
      public static var avatar_editor_tabs_gender_male:Class = gender_male_1_png;
      
      public static var avatar_editor_tabs_gender_male_off:Class = gender_male_off_1_png;
      
      public static var avatar_editor_tabs_head_accessories:Class = head_accessories_1_png;
      
      public static var avatar_editor_tabs_head_accessories_off:Class = head_accessories_off_1_png;
      
      public static var avatar_editor_tabs_head_eyewear:Class = head_eyewear_1_png;
      
      public static var avatar_editor_tabs_head_eyewear_off:Class = head_eyewear_off_1_png;
      
      public static var avatar_editor_tabs_head_face_accessories:Class = head_face_accessories_1_png;
      
      public static var avatar_editor_tabs_head_face_accessories_off:Class = head_face_accessories_off_1_png;
      
      public static var avatar_editor_tabs_head_hair:Class = head_hair_1_png;
      
      public static var avatar_editor_tabs_head_hair_off:Class = head_hair_off_1_png;
      
      public static var avatar_editor_tabs_head_hats:Class = head_hats_1_png;
      
      public static var avatar_editor_tabs_head_hats_off:Class = head_hats_off_1_png;
      
      public static var avatar_editor_tabs_icon_misc_misc:Class = icon_misc_misc_1_png;
      
      public static var avatar_editor_tabs_icon_misc_misc_off:Class = icon_misc_misc_off_1_png;
      
      public static var avatar_editor_tabs_icon_misc_pets:Class = icon_misc_pets_1_png;
      
      public static var avatar_editor_tabs_icon_misc_pets_off:Class = icon_misc_pets_off_1_png;
      
      public static var avatar_editor_tabs_top_accessories:Class = top_accessories_1_png;
      
      public static var avatar_editor_tabs_top_accessories_off:Class = top_accessories_off_1_png;
      
      public static var avatar_editor_tabs_top_jacket:Class = top_jacket_1_png;
      
      public static var avatar_editor_tabs_top_jacket_off:Class = top_jacket_off_1_png;
      
      public static var avatar_editor_tabs_top_prints:Class = top_prints_1_png;
      
      public static var avatar_editor_tabs_top_prints_off:Class = top_prints_off_1_png;
      
      public static var avatar_editor_tabs_top_shirt:Class = top_shirt_1_png;
      
      public static var avatar_editor_tabs_top_shirt_off:Class = top_shirt_off_1_png;
      
      public static var avatar_editor_wardrobe_select_outfit:Class = select_outfit_1_png;
      
      public static var avatar_editor_wardrobe_select_outfit_over:Class = select_outfit_over_1_png;
      
      public static var avatar_editor_wardrobe_wardrobe_empty_slot:Class = wardrobe_empty_slot_1_png;
      
      public static var bottom_bar_buildersclub:Class = buildersclub_1_png;
      
      public static var bottom_bar_camera:Class = camera_1_png;
      
      public static var bottom_bar_wired_menu:Class = wired_menu_1_png;
      
      public static var bottom_bar_collapse_left:Class = collapse_left_1_png;
      
      public static var bottom_bar_collapse_right:Class = collapse_right_1_png;
      
      public static var bottom_bar_divider_1px:Class = divider_1px_1_png;
      
      public static var bottom_bar_games:Class = games_1_png;
      
      public static var bottom_bar_home:Class = home_2_png;
      
      public static var bottom_bar_inventory:Class = inventory_1_png;
      
      public static var bottom_bar_logo:Class = logo_2_png;
      
      public static var bottom_bar_navigator:Class = navigator_1_png;
      
      public static var bottom_bar_memenu_bg:Class = memenu_bg_1_png;
      
      public static var bottom_bar_memenu_circle:Class = memenu_circle_1_png;
      
      public static var bottom_bar_progression:Class = progression_1_png;
      
      public static var bottom_bar_shop:Class = shop_1_png;
      
      public static var bottom_bar_stories:Class = stories_1_png;
      
      public static var camera_arrow_gray:Class = arrow_gray_1_png;
      
      public static var camera_arrow_green:Class = arrow_green_1_png;
      
      public static var camera_browse_ffwd:Class = browse_ffwd_1_png;
      
      public static var camera_cam_bg:Class = cam_bg_1_png;
      
      public static var camera_cam_btn_hi:Class = cam_btn_hi_1_png;
      
      public static var camera_cam_close_x:Class = cam_close_x_1_png;
      
      public static var camera_camera_btn:Class = camera_btn_1_png;
      
      public static var camera_camera_btn_down:Class = camera_btn_down_1_png;
      
      public static var camera_camera_edit:Class = camera_edit_1_png;
      
      public static var camera_camera_icon:Class = camera_icon_1_png;
      
      public static var camera_fx_button_active:Class = fx_button_active_1_png;
      
      public static var camera_fx_button_outline:Class = fx_button_outline_1_png;
      
      public static var camera_fx_button_selected:Class = fx_button_selected_1_png;
      
      public static var camera_fx_frame_selected:Class = fx_frame_selected_1_png;
      
      public static var camera_fx_slider_bottom_active:Class = fx_slider_bottom_active_1_png;
      
      public static var camera_fx_slider_button:Class = fx_slider_button_1_png;
      
      public static var camera_habbo_camera:Class = habbo_camera_1_png;
      
      public static var camera_icon_colorfilter:Class = icon_colorfilter_1_png;
      
      public static var camera_icon_compositefilter:Class = icon_compositefilter_1_png;
      
      public static var camera_icon_frame:Class = icon_frame_1_png;
      
      public static var camera_locked:Class = locked_1_png;
      
      public static var camera_photo_border:Class = photo_border_1_png;
      
      public static var camera_remove_effect:Class = remove_effect_1_png;
      
      public static var camera_retake_button:Class = retake_button_1_png;
      
      public static var camera_shadow_outline:Class = shadow_outline_1_png;
      
      public static var camera_viewfinder:Class = viewfinder_1_png;
      
      public static var camera_zoom_in:Class = zoom_in_2_png;
      
      public static var camera_zoom_out:Class = zoom_out_1_png;
      
      public static var campaign_calendar_day_generic_activated:Class = day_generic_activated_1_png;
      
      public static var campaign_calendar_day_generic_bg:Class = day_generic_bg_1_png;
      
      public static var campaign_calendar_day_generic_button:Class = day_generic_button_1_png;
      
      public static var campaign_calendar_generic_lock:Class = generic_lock_1_png;
      
      public static var campaign_calendar_icon_advent:Class = icon_advent_1_png;
      
      public static var campaign_calendar_opened:Class = opened_1_png;
      
      public static var catalogue_background:Class = background_1_png;
      
      public static var catalogue_badge_background:Class = badge_background_1_png;
      
      public static var catalogue_chatstyle_background:Class = chatstyle_background_1_png;
      
      public static var catalogue_bundle_star:Class = bundle_star_1_png;
      
      public static var catalogue_clakboard:Class = clakboard_1_png;
      
      public static var catalogue_color_picker_27x22_border:Class = color_picker_27x22_border_1_png;
      
      public static var catalogue_color_picker_27x22_color:Class = color_picker_27x22_color_1_png;
      
      public static var catalogue_color_picker_27x22_selection:Class = color_picker_27x22_selection_1_png;
      
      public static var catalogue_effects_ninja:Class = effects_ninja_1_png;
      
      public static var catalogue_giftcard_blank:Class = giftcard_blank_2_png;
      
      public static var catalogue_giftcard_staff:Class = giftcard_staff_1_png;
      
      public static var catalogue_giftcard_staff_icon:Class = giftcard_staff_icon_1_png;
      
      public static var catalogue_ui2_checkmark_m:Class = ui2_checkmark_m_1_png;
      
      public static var catalogue_icon_alert_s:Class = icon_alert_s_1_png;
      
      public static var catalogue_giftcard_icon_bgstar:Class = giftcard_icon_bgstar_1_png;
      
      public static var catalogue_ufo_pricebg:Class = ufo_pricebg_1_png;
      
      public static var chest_overlay_brown_background:Class = brown_background_1_png;
      
      public static var chest_overlay_brown_plaque:Class = brown_plaque_1_png;
      
      public static var chest_overlay_gold_background:Class = gold_background_1_png;
      
      public static var chest_overlay_gold_plaque:Class = gold_plaque_1_png;
      
      public static var chest_overlay_shine:Class = shine_1_png;
      
      public static var chest_overlay_silver_background:Class = silver_background_1_png;
      
      public static var chest_overlay_silver_plaque:Class = silver_plaque_1_png;
      
      public static var common_beta_sign:Class = beta_sign_1_png;
      
      public static var common_blue_arrow_horizontal:Class = blue_arrow_horizontal_1_png;
      
      public static var common_blue_arrow_vertical:Class = blue_arrow_vertical_1_png;
      
      public static var common_chat_indicator:Class = chat_indicator_1_png;
      
      public static var common_chat_style_block:Class = chat_style_block_1_png;
      
      public static var common_chat_styles:Class = chat_styles_1_png;
      
      public static var common_check_mark:Class = check_mark_1_png;
      
      public static var common_chisel:Class = chisel_1_png;
      
      public static var common_close_x:Class = close_x_1_png;
      
      public static var common_cross_mark:Class = cross_mark_1_png;
      
      public static var common_green_arrow_horizontal:Class = green_arrow_horizontal_1_png;
      
      public static var common_green_arrow_vertical:Class = green_arrow_vertical_1_png;
      
      public static var common_hilight_big:Class = hilight_big_1_png;
      
      public static var common_icon_task_completed_m:Class = icon_task_completed_m_1_png;
      
      public static var common_icon_task_completed_s:Class = icon_task_completed_s_1_png;
      
      public static var common_info_icon_grey:Class = info_icon_grey_1_png;
      
      public static var common_item_selected:Class = item_selected_1_png;
      
      public static var common_item_unselected:Class = item_unselected_1_png;
      
      public static var common_loading_icon:Class = loading_icon_1_png;
      
      public static var common_maximize:Class = maximize_1_png;
      
      public static var common_maximize_unetched:Class = maximize_unetched_1_png;
      
      public static var common_minimize_unetched:Class = minimize_unetched_1_png;
      
      public static var common_offers_icon:Class = offers_icon_1_png;
      
      public static var common_promo_arrow_close:Class = promo_arrow_close_1_png;
      
      public static var common_promo_arrow_top_right:Class = promo_arrow_top_right_1_png;
      
      public static var common_small_coin:Class = small_coin_1_png;
      
      public static var common_small_pen:Class = small_pen_1_png;
      
      public static var common_star:Class = star_1_png;
      
      public static var common_trashcan_big:Class = trashcan_big_1_png;
      
      public static var common_trashcan_small:Class = trashcan_small_1_png;
      
      public static var common_welcome_screen_arrow:Class = welcome_screen_arrow_1_png;
      
      public static var craft_craft_bg:Class = craft_bg_1_png;
      
      public static var discord_discord_box:Class = discord_box_1_png;
      
      public static var discord_collectibles_logo:Class = collectibles_logo_1_png;
      
      public static var discord_origins_logo:Class = origins_logo_1_png;
      
      public static var discord_wired_logo:Class = wired_logo_1_png;
      
      public static var extended_profile_clear_favourite:Class = clear_favourite_1_png;
      
      public static var extended_profile_icon_level:Class = icon_level_1_png;
      
      public static var extended_profile_icon_star_gem:Class = icon_star_gem_1_png;
      
      public static var extended_profile_make_favourite:Class = make_favourite_2_png;
      
      public static var extended_profile_rooms:Class = rooms_1_png;
      
      public static var extended_profile_frank_stop:Class = frank_stop_1_png;
      
      public static var extended_profile_block_icon:Class = block_icon_1_png;
      
      public static var floor_plan_editor_add_tile:Class = add_tile_1_png;
      
      public static var floor_plan_editor_enter_tile:Class = enter_tile_1_png;
      
      public static var floor_plan_editor_logo:Class = logo_1_png;
      
      public static var floor_plan_editor_raise_tile:Class = raise_tile_1_png;
      
      public static var floor_plan_editor_remove_tile:Class = remove_tile_1_png;
      
      public static var floor_plan_editor_sink_tile:Class = sink_tile_1_png;
      
      public static var forum_forum_edit:Class = forum_edit_1_png;
      
      public static var forum_forum_hide:Class = forum_hide_1_png;
      
      public static var forum_forum_list0:Class = forum_list0_1_png;
      
      public static var forum_forum_list1:Class = forum_list1_1_png;
      
      public static var forum_forum_list2:Class = forum_list2_1_png;
      
      public static var forum_forum_locked:Class = forum_locked_1_png;
      
      public static var forum_forum_pinned:Class = forum_pinned_1_png;
      
      public static var forum_forum_report:Class = forum_report_1_png;
      
      public static var forum_forum_unhide:Class = forum_unhide_1_png;
      
      public static var forum_forum_unlocked:Class = forum_unlocked_1_png;
      
      public static var forum_forum_unpinned:Class = forum_unpinned_1_png;
      
      public static var forum_reply:Class = reply_1_png;
      
      public static var franks_emotions_angry:Class = angry_1_png;
      
      public static var franks_emotions_blush:Class = blush_1_png;
      
      public static var franks_emotions_heart:Class = heart_1_png;
      
      public static var franks_emotions_poop:Class = poop_1_png;
      
      public static var franks_emotions_sad:Class = sad_1_png;
      
      public static var friend_bar_all_friends:Class = all_friends_1_png;
      
      public static var friend_bar_event_notification_icon:Class = event_notification_icon_1_png;
      
      public static var friend_bar_friendlist_chat:Class = friendlist_chat_1_png;
      
      public static var friend_bar_friendlist_eye:Class = friendlist_eye_1_png;
      
      public static var friend_bar_friendlist_go_room:Class = friendlist_go_room_1_png;
      
      public static var friend_bar_friendlist_messenger:Class = friendlist_messenger_1_png;
      
      public static var friend_bar_friendlist_messenger_notify_0:Class = friendlist_messenger_notify_0_1_png;
      
      public static var friend_bar_friendlist_messenger_notify_1:Class = friendlist_messenger_notify_1_1_png;
      
      public static var friend_bar_friends_browse_bg:Class = friends_browse_bg_1_png;
      
      public static var friend_bar_search_habbos:Class = search_habbos_1_png;
      
      public static var game_center_achievement_locked_icon:Class = achievement_locked_icon_1_png;
      
      public static var game_center_loading_icon:Class = loading_icon_3_png;
      
      public static var game_center_snowball_notification_icon:Class = snowball_notification_icon_1_png;
      
      public static var group_guild_color_btm:Class = guild_color_btm_1_png;
      
      public static var group_guild_color_top:Class = guild_color_top_1_png;
      
      public static var hc_center_hc_center_cover:Class = hc_center_cover_1_png;
      
      public static var hc_center_hc_center_icon_credits:Class = hc_center_icon_credits_1_png;
      
      public static var hc_center_hc_center_illustration:Class = hc_center_illustration_1_png;
      
      public static var hc_center_hc_center_timer:Class = hc_center_timer_1_png;
      
      public static var hc_center_hc_postit_bg:Class = hc_postit_bg_1_png;
      
      public static var hc_center_t0:Class = t0_1_png;
      
      public static var hc_center_t1:Class = t1_1_png;
      
      public static var hc_center_t2:Class = t2_1_png;
      
      public static var hc_center_t3:Class = t3_1_png;
      
      public static var hc_center_t4:Class = t4_1_png;
      
      public static var hc_center_t5:Class = t5_1_png;
      
      public static var hc_center_t6:Class = t6_1_png;
      
      public static var hc_center_t7:Class = t7_1_png;
      
      public static var hc_center_t8:Class = t8_1_png;
      
      public static var hc_center_t9:Class = t9_1_png;
      
      public static var bg_star_300x300:Class = bg_star_300x300_1_png;
      
      public static var collectables_level_bg:Class = coll_hcs_level_bg_1_png;
      
      public static var collectables_score_element:Class = coll_hcs_score_element_1_png;
      
      public static var collectables_score_element2:Class = coll_hcs_score_element2_1_png;
      
      public static var collectables_reward_rarity_flag:Class = coll_reward_rarity_flag_1_png;
      
      public static var collectables_score_background:Class = coll_bg_pattern_1_png;
      
      public static var collectables_score_background_right:Class = coll_bg_pattern_right_1_png;
      
      public static var collectables_score_background_gradient:Class = coll_window_top_gradient_1_png;
      
      public static var collectables_score_background_gradient2:Class = coll_window_top_gradient2_1_png;
      
      public static var collectables_transfer_safe:Class = coll_transfer_safe_1_png;
      
      public static var collectables_cabinet_element:Class = coll_window_top_image_cabinet_1_png;
      
      public static var collectables_collection_default:Class = image_collection_default_1_png;
      
      public static var collectables_icon_curator_stamp_small:Class = icon_curator_stamp_small_1_png;
      
      public static var collectables_icon_curator_stamp_large:Class = icon_curator_stamp_large_1_png;
      
      public static var collectables_lock_closed:Class = lock_closed_1_png;
      
      public static var collectables_lock_open:Class = lock_open_1_png;
      
      public static var image_connection_problem:Class = image_connection_problem_1_png;
      
      public static var image_frank_dont_know:Class = image_frank_dont_know_1_png;
      
      public static var icon_checkmark_small:Class = icon_checkmark_small_1_png;
      
      public static var icon_habbicon_fav:Class = icon_habbicon_fav_1_png;
      
      public static var habbicons_submenu_icon_default:Class = habbicons_submenu_icon_default_1_png;
      
      public static var habbicons_submenu_icon_owned:Class = habbicons_submenu_icon_owned_1_png;
      
      public static var icon_notification_corner_mid:Class = icon_notification_corner_mid_1_png;
      
      public static var bg_pattern_001:Class = bg_pattern_001_1_png;
      
      public static var habbicon_topbar_left:Class = habbicon_topbar_left_1_png;
      
      public static var habbicon_topbar_mid:Class = habbicon_topbar_mid_1_png;
      
      public static var habbicon_topbar_right:Class = habbicon_topbar_right_1_png;
      
      public static var habbicons_clip:Class = clip_1_png;
      
      public static var habbicons_habbicons_dm:Class = habbicons_dm_1_png;
      
      public static var habbicons_habbicons_logo:Class = habbicons_logo_1_png;
      
      public static var habbicons_sticky_note:Class = sticky_note_1_png;
      
      public static var habbicons_sticky_note2:Class = sticky_note2_1_png;
      
      public static var loading:Class = loading_1_png;
      
      public static var help_accept_icon:Class = accept_icon_1_png;
      
      public static var help_bandaid:Class = bandaid_1_png;
      
      public static var help_chat_review_anonymous:Class = anonymous_1_png;
      
      public static var help_chat_review_avatar_anonymous:Class = avatar_anonymous_1_png;
      
      public static var help_chat_review_avatar_perpetrator:Class = avatar_perpetrator_1_png;
      
      public static var help_chat_review_decision_bad:Class = decision_bad_1_png;
      
      public static var help_chat_review_decision_ok:Class = decision_ok_1_png;
      
      public static var help_chat_review_decision_refused:Class = decision_refused_1_png;
      
      public static var help_chat_review_decision_searching_1:Class = decision_searching_1_1_png;
      
      public static var help_chat_review_decision_searching_2:Class = decision_searching_2_1_png;
      
      public static var help_chat_review_decision_undecided:Class = decision_undecided_1_png;
      
      public static var help_chat_review_decision_very_bad:Class = decision_very_bad_1_png;
      
      public static var help_chat_review_decision_waiting_1:Class = decision_waiting_1_1_png;
      
      public static var help_chat_review_decision_waiting_2:Class = decision_waiting_2_1_png;
      
      public static var help_chat_review_perpetrator:Class = perpetrator_1_png;
      
      public static var help_chat_review_progress_big_1:Class = progress_big_1_1_png;
      
      public static var help_chat_review_progress_big_2:Class = progress_big_2_1_png;
      
      public static var help_chat_review_progress_big_3:Class = progress_big_3_1_png;
      
      public static var help_chat_review_progress_big_4:Class = progress_big_4_1_png;
      
      public static var help_chat_review_vote_bad:Class = vote_bad_1_png;
      
      public static var help_chat_review_vote_bad_down:Class = vote_bad_down_1_png;
      
      public static var help_chat_review_vote_bad_over:Class = vote_bad_over_1_png;
      
      public static var help_chat_review_vote_ok:Class = vote_ok_1_png;
      
      public static var help_chat_review_vote_ok_down:Class = vote_ok_down_1_png;
      
      public static var help_chat_review_vote_ok_over:Class = vote_ok_over_1_png;
      
      public static var help_chat_review_vote_very_bad:Class = vote_very_bad_1_png;
      
      public static var help_chat_review_vote_very_bad_down:Class = vote_very_bad_down_1_png;
      
      public static var help_chat_review_vote_very_bad_over:Class = vote_very_bad_over_1_png;
      
      public static var help_citizenship_default:Class = citizenship_default_1_png;
      
      public static var help_decline_icon:Class = decline_icon_1_png;
      
      public static var help_error_state:Class = error_state_1_png;
      
      public static var help_feeling_confused:Class = feeling_confused_1_png;
      
      public static var help_feeling_confused_coming_up:Class = feeling_confused_coming_up_1_png;
      
      public static var help_frank_greeting:Class = frank_greeting_1_png;
      
      public static var help_guide_accept:Class = guide_accept_1_png;
      
      public static var help_guide_icon:Class = guide_icon_1_png;
      
      public static var help_habboway_correct:Class = correct_1_png;
      
      public static var help_habboway_dove_off:Class = dove_off_1_png;
      
      public static var help_habboway_dove_on:Class = dove_on_1_png;
      
      public static var help_habboway_dove_quizz:Class = dove_quizz_1_png;
      
      public static var help_habboway_next:Class = next_1_png;
      
      public static var help_habboway_prev:Class = prev_2_png;
      
      public static var help_habboway_wrong:Class = wrong_1_png;
      
      public static var help_help_duck:Class = help_duck_1_png;
      
      public static var help_illustrations_bully:Class = bully_1_png;
      
      public static var help_illustrations_question:Class = question_1_png;
      
      public static var help_illustrations_tour:Class = tour_1_png;
      
      public static var help_need_help:Class = need_help_1_png;
      
      public static var help_notification:Class = notification_1_png;
      
      public static var help_poor_frank:Class = poor_frank_1_png;
      
      public static var help_requester_icon:Class = requester_icon_1_png;
      
      public static var help_user_create:Class = user_create_1_png;
      
      public static var help_user_feedback:Class = user_feedback_1_png;
      
      public static var help_user_pending:Class = user_pending_1_png;
      
      public static var high_score_highscore_cup:Class = highscore_cup_1_png;
      
      public static var icons_back:Class = back_1_png;
      
      public static var icons_back_small:Class = back_small_1_png;
      
      public static var icons_builder_error_full:Class = error_full_1_png;
      
      public static var icons_builder_error_furnilimit:Class = error_furnilimit_1_png;
      
      public static var icons_builder_error_grouproom:Class = error_grouproom_1_png;
      
      public static var icons_builder_error_notroom:Class = error_notroom_1_png;
      
      public static var icons_builder_error_room:Class = error_room_1_png;
      
      public static var icons_builder_error_userinroom:Class = error_userinroom_1_png;
      
      public static var icons_close:Class = close_1_png;
      
      public static var icons_facebook:Class = facebook_1_png;
      
      public static var icons_flag:Class = flag_1_png;
      
      public static var icons_forward:Class = forward_1_png;
      
      public static var icons_forward_small:Class = forward_small_1_png;
      
      public static var icons_go_to_room_icon:Class = go_to_room_icon_1_png;
      
      public static var icons_hc_icon_small:Class = hc_icon_small_1_png;
      
      public static var icons_hilighter_yellow:Class = hilighter_yellow_1_png;
      
      public static var icons_info_grey:Class = info_grey_1_png;
      
      public static var icons_link_icon:Class = link_icon_1_png;
      
      public static var icons_next:Class = next_2_png;
      
      public static var icons_panic:Class = panic_1_png;
      
      public static var icons_share:Class = share_1_png;
      
      public static var icons_star:Class = star_2_png;
      
      public static var icons_tickmark:Class = tickmark_1_png;
      
      public static var icons_toolbar_achievements_hover:Class = achievements_hover_1_png;
      
      public static var icons_toolbar_achievements_normal:Class = achievements_normal_1_png;
      
      public static var icons_toolbar_builder_hover:Class = builder_hover_1_png;
      
      public static var icons_toolbar_builder_normal:Class = builder_normal_1_png;
      
      public static var icons_toolbar_catalogue_hover:Class = catalogue_hover_1_png;
      
      public static var icons_toolbar_catalogue_normal:Class = catalogue_normal_1_png;
      
      public static var icons_toolbar_divider:Class = divider_1_png;
      
      public static var icons_toolbar_games_hover:Class = games_hover_1_png;
      
      public static var icons_toolbar_games_normal:Class = games_normal_1_png;
      
      public static var icons_toolbar_home_hover:Class = home_hover_1_png;
      
      public static var icons_toolbar_home_normal:Class = home_normal_1_png;
      
      public static var icons_toolbar_inventory_hover:Class = inventory_hover_1_png;
      
      public static var icons_toolbar_inventory_normal:Class = inventory_normal_1_png;
      
      public static var icons_toolbar_me_menu_placeholder:Class = me_menu_placeholder_1_png;
      
      public static var icons_toolbar_minimail_hover:Class = minimail_hover_1_png;
      
      public static var icons_toolbar_minimail_normal:Class = minimail_normal_1_png;
      
      public static var icons_toolbar_navigator_hover:Class = navigator_hover_1_png;
      
      public static var icons_toolbar_navigator_normal:Class = navigator_normal_1_png;
      
      public static var icons_toolbar_progression_hover:Class = progression_hover_1_png;
      
      public static var icons_toolbar_progression_normal:Class = progression_normal_1_png;
      
      public static var icons_toolbar_reception_hover:Class = reception_hover_1_png;
      
      public static var icons_toolbar_reception_normal:Class = reception_normal_1_png;
      
      public static var icons_toolbar_stories_hover:Class = stories_hover_1_png;
      
      public static var icons_toolbar_stories_normal:Class = stories_normal_1_png;
      
      public static var icons_toolbar_valentines_hover:Class = valentines_hover_1_png;
      
      public static var icons_toolbar_valentines_normal:Class = valentines_normal_1_png;
      
      public static var icons_toolbar_xmas_hover:Class = xmas_hover_1_png;
      
      public static var icons_toolbar_xmas_normal:Class = xmas_normal_1_png;
      
      public static var icons_twitter:Class = twitter_1_png;
      
      public static var icons_wearable:Class = wearable_1_png;
      
      public static var illumina_horizontal_separator:Class = horizontal_separator_1_png;
      
      public static var illumina_wired_bg_left_repeating:Class = wired_bg_left_repeating_1_png;
      
      public static var illumina_wired_bg_left:Class = wired_bg_left_1_png;
      
      public static var illumina_wired_bg_right:Class = wired_bg_right_1_png;
      
      public static var infostand_bot_info_bg:Class = bot_info_bg_1_png;
      
      public static var infostand_furni_place:Class = furni_place_1_png;
      
      public static var infostand_furni_shop:Class = furni_shop_1_png;
      
      public static var inventory_download_icon:Class = download_icon_1_png;
      
      public static var inventory_furni_icon_credits:Class = icon_credits_1_png;
      
      public static var inventory_furni_icon_floor:Class = icon_floor_1_png;
      
      public static var inventory_furni_icon_landscape:Class = icon_landscape_1_png;
      
      public static var inventory_furni_icon_wallpaper:Class = icon_wallpaper_1_png;
      
      public static var inventory_furni_no_recycle_icon:Class = no_recycle_icon_1_png;
      
      public static var inventory_furni_no_trade_icon:Class = no_trade_icon_1_png;
      
      public static var inventory_furni_recycle_icon:Class = recycle_icon_1_png;
      
      public static var inventory_furni_trade_icon:Class = trade_icon_1_png;
      
      public static var inventory_inventory_empty:Class = inventory_empty_1_png;
      
      public static var inventory_inventory_icon:Class = inventory_icon_1_png;
      
      public static var inventory_thumb_bg:Class = thumb_bg_1_png;
      
      public static var inventory_thumb_bg_selected:Class = thumb_bg_selected_2_png;
      
      public static var inventory_thumb_icon_recycle:Class = thumb_icon_recycle_1_png;
      
      public static var inventory_thumb_rent_ending:Class = thumb_rent_ending_1_png;
      
      public static var inventory_thumb_rent_started:Class = thumb_rent_started_1_png;
      
      public static var inventory_thumb_rent_not_started:Class = thumb_rent_not_started_1_png;
      
      public static var inventory_thumb_selected_outline:Class = thumb_selected_outline_1_png;
      
      public static var inventory_trading_trading_arrow_icon:Class = trading_arrow_icon_1_png;
      
      public static var inventory_trading_trading_locked_icon:Class = trading_locked_icon_1_png;
      
      public static var inventory_trading_trading_unlocked_icon:Class = trading_unlocked_icon_1_png;
      
      public static var inventory_trading_trading_split_icon:Class = trading_split_icon_1_png;
      
      public static var inventory_trading_trading_silver_arrow_left:Class = trading_silver_arrow_left_1_png;
      
      public static var inventory_trading_trading_silver_arrow_right:Class = trading_silver_arrow_right_1_png;
      
      public static var landing_view_avatar_info_background:Class = avatar_info_background_1_png;
      
      public static var landing_view_needle_meter_needle0:Class = meter_needle0_1_png;
      
      public static var landing_view_needle_meter_needle1:Class = meter_needle1_1_png;
      
      public static var landing_view_needle_meter_needle10:Class = meter_needle10_1_png;
      
      public static var landing_view_needle_meter_needle11:Class = meter_needle11_1_png;
      
      public static var landing_view_needle_meter_needle12:Class = meter_needle12_1_png;
      
      public static var landing_view_needle_meter_needle13:Class = meter_needle13_1_png;
      
      public static var landing_view_needle_meter_needle14:Class = meter_needle14_1_png;
      
      public static var landing_view_needle_meter_needle15:Class = meter_needle15_1_png;
      
      public static var landing_view_needle_meter_needle16:Class = meter_needle16_1_png;
      
      public static var landing_view_needle_meter_needle17:Class = meter_needle17_1_png;
      
      public static var landing_view_needle_meter_needle18:Class = meter_needle18_1_png;
      
      public static var landing_view_needle_meter_needle19:Class = meter_needle19_1_png;
      
      public static var landing_view_needle_meter_needle2:Class = meter_needle2_1_png;
      
      public static var landing_view_needle_meter_needle20:Class = meter_needle20_1_png;
      
      public static var landing_view_needle_meter_needle21:Class = meter_needle21_1_png;
      
      public static var landing_view_needle_meter_needle22:Class = meter_needle22_1_png;
      
      public static var landing_view_needle_meter_needle23:Class = meter_needle23_1_png;
      
      public static var landing_view_needle_meter_needle3:Class = meter_needle3_1_png;
      
      public static var landing_view_needle_meter_needle4:Class = meter_needle4_1_png;
      
      public static var landing_view_needle_meter_needle5:Class = meter_needle5_1_png;
      
      public static var landing_view_needle_meter_needle6:Class = meter_needle6_1_png;
      
      public static var landing_view_needle_meter_needle7:Class = meter_needle7_1_png;
      
      public static var landing_view_needle_meter_needle8:Class = meter_needle8_1_png;
      
      public static var landing_view_needle_meter_needle9:Class = meter_needle9_1_png;
      
      public static var landing_view_reception_horizontal:Class = reception_horizontal_1_png;
      
      public static var me_menu_me_achv:Class = me_achv_1_png;
      
      public static var me_menu_me_clothing:Class = me_clothing_1_png;
      
      public static var me_menu_me_forums:Class = me_forums_1_png;
      
      public static var me_menu_me_cabinet:Class = me_cabinet_1_png;
      
      public static var me_menu_me_guide:Class = me_guide_1_png;
      
      public static var me_menu_me_mail:Class = me_mail_1_png;
      
      public static var me_menu_me_profile:Class = me_profile_1_png;
      
      public static var me_menu_me_rooms:Class = me_rooms_1_png;
      
      public static var me_menu_me_talents:Class = me_talents_1_png;
      
      public static var prog_menu_daily_tasks:Class = prog_daily_tasks_1_png;
      
      public static var prog_menu_quests:Class = prog_quests_1_png;
      
      public static var prog_menu_leaderboards:Class = prog_leaderboards_1_png;
      
      public static var prog_menu_introduction:Class = prog_introduction_1_png;
      
      public static var messenger_caution:Class = caution_1_png;
      
      public static var messenger_minimize_button:Class = minimize_button_1_png;
      
      public static var messenger_notification_icon:Class = notification_icon_1_png;
      
      public static var messenger_profile_icon:Class = profile_icon_1_png;
      
      public static var messenger_visit_icon:Class = visit_icon_1_png;
      
      public static var missing_image_icon:Class = missing_image_icon_1_png;
      
      public static var mysterybox_box_base:Class = box_base_1_png;
      
      public static var mysterybox_box_overlay:Class = box_overlay_1_png;
      
      public static var mysterybox_box_small:Class = box_small_1_png;
      
      public static var mysterybox_key_base:Class = key_base_1_png;
      
      public static var mysterybox_key_overlay:Class = key_overlay_1_png;
      
      public static var mysterybox_key_small:Class = key_small_1_png;
      
      public static var mysterybox_tracker_border:Class = tracker_border_1_png;
      
      public static var navigation_icon_weblink:Class = icon_weblink_2_png;
      
      public static var newnavigator_button_back:Class = button_back_1_png;
      
      public static var newnavigator_button_category_collapse:Class = button_category_collapse_1_png;
      
      public static var newnavigator_button_category_expand:Class = button_category_expand_1_png;
      
      public static var newnavigator_button_category_show_more:Class = button_category_show_more_1_png;
      
      public static var newnavigator_button_leftpane_hide:Class = button_leftpane_hide_1_png;
      
      public static var newnavigator_button_leftpane_show:Class = button_leftpane_show_1_png;
      
      public static var newnavigator_button_quicklink_add:Class = button_quicklink_add_1_png;
      
      public static var newnavigator_button_quicklink_remove:Class = button_quicklink_remove_1_png;
      
      public static var newnavigator_button_rows:Class = button_rows_1_png;
      
      public static var newnavigator_button_show_room_info:Class = button_show_room_info_1_png;
      
      public static var newnavigator_button_tiles:Class = button_tiles_1_png;
      
      public static var newnavigator_create_room:Class = create_room_1_png;
      
      public static var newnavigator_default_room:Class = default_room_1_png;
      
      public static var newnavigator_doormode_doorbell_small:Class = doormode_doorbell_small_2_png;
      
      public static var newnavigator_doormode_invisible_small:Class = doormode_invisible_small_1_png;
      
      public static var newnavigator_doormode_password_small:Class = doormode_password_small_2_png;
      
      public static var newnavigator_event_icon:Class = event_icon_1_png;
      
      public static var newnavigator_group_base_icon:Class = group_base_icon_2_png;
      
      public static var newnavigator_icon_fav_no:Class = icon_fav_no_1_png;
      
      public static var newnavigator_icon_fav_yes:Class = icon_fav_yes_1_png;
      
      public static var newnavigator_icon_group:Class = icon_group_1_png;
      
      public static var newnavigator_icon_group_admin:Class = icon_group_admin_1_png;
      
      public static var newnavigator_icon_group_owner:Class = icon_group_owner_1_png;
      
      public static var newnavigator_icon_home_no:Class = icon_home_no_1_png;
      
      public static var newnavigator_icon_home_yes:Class = icon_home_yes_1_png;
      
      public static var newnavigator_icon_ql_add:Class = icon_ql_add_1_png;
      
      public static var newnavigator_icon_ql_remove:Class = icon_ql_remove_1_png;
      
      public static var newnavigator_icon_quicklink_plain:Class = icon_quicklink_plain_1_png;
      
      public static var newnavigator_icon_usercount:Class = icon_usercount_1_png;
      
      public static var newnavigator_nav_view_mini:Class = nav_view_mini_1_png;
      
      public static var newnavigator_nav_view_row:Class = nav_view_row_1_png;
      
      public static var newnavigator_nav_view_thumbs:Class = nav_view_thumbs_1_png;
      
      public static var newnavigator_promote_room:Class = promote_room_1_png;
      
      public static var newnavigator_random_room:Class = random_room_1_png;
      
      public static var newnavigator_rating_star_off:Class = rating_star_off_1_png;
      
      public static var newnavigator_rating_star_on:Class = rating_star_on_1_png;
      
      public static var newnavigator_refresh_search_icon:Class = refresh_search_icon_1_png;
      
      public static var newnavigator_report_room:Class = report_room_1_png;
      
      public static var newnavigator_room_settings_icon:Class = room_settings_icon_1_png;
      
      public static var newnavigator_roominfo_temp:Class = roominfo_temp_1_png;
      
      public static var newnavigator_roomusercount_dimmer_black:Class = roomusercount_dimmer_black_1_png;
      
      public static var nft_icon_pixel_0:Class = icon_pixel_0_3_png;
      
      public static var nft_icon_24x24:Class = icon_nft_24x24_1_png;
      
      public static var notification_friendonline_circle:Class = friendonline_circle_1_png;
      
      public static var notification_friendonline_circle_inner:Class = friendonline_circle_inner_1_png;
      
      public static var notification_friendonline_left:Class = friendonline_left_1_png;
      
      public static var notification_friendonline_middle:Class = friendonline_middle_1_png;
      
      public static var notification_friendonline_right:Class = friendonline_right_1_png;
      
      public static var notification_friendonline_slide:Class = friendonline_slide_1_png;
      
      public static var poll_poll_prompt_frank:Class = poll_prompt_frank_1_png;
      
      public static var poll_poll_prompt_question:Class = poll_prompt_question_1_png;
      
      public static var pursearea_credits_icon:Class = credits_icon_1_png;
      
      public static var pursearea_credits_icon2:Class = credits_icon2_1_png;
      
      public static var pursearea_diamond_icon:Class = diamond_icon_1_png;
      
      public static var pursearea_duckets_icon:Class = duckets_icon_1_png;
      
      public static var pursearea_tiny_emerald_icon:Class = icon_currency_emerald_tiny_1_png;
      
      public static var pursearea_mid_emerald_icon:Class = icon_currency_emerald_mid_1_png;
      
      public static var pursearea_tiny_silver_icon:Class = icon_currency_silver_tiny_1_png;
      
      public static var pursearea_mid_silver_icon:Class = icon_currency_silver_mid_1_png;
      
      public static var pursearea_hc_icon:Class = hc_icon_1_png;
      
      public static var pursearea_logout_icon:Class = logout_icon_1_png;
      
      public static var pursearea_loyalty_icon:Class = loyalty_icon_1_png;
      
      public static var pursearea_settings_icon:Class = settings_icon_1_png;
      
      public static var pursearea_unseen_indicator:Class = unseen_indicator_1_png;
      
      public static var pursearea_vault_icon:Class = vault_icon_1_png;
      
      public static var pursearea_icon_earnings:Class = icon_earnings_1_png;
      
      public static var rarity_item_rarity_item_plaque:Class = rarity_item_plaque_1_png;
      
      public static var rarity_item_rarity_preview_bg:Class = rarity_preview_bg_1_png;
      
      public static var reward_track_checkmark:Class = checkmark_1_png;
      
      public static var reward_track_available_icon:Class = available_icon_1_png;
      
      public static var reward_track_frank_and_piccolo:Class = frank_and_piccolo_1_png;
      
      public static var reward_track_frank_tips:Class = frank_tips_1_png;
      
      public static var reward_track_free_track:Class = free_track_1_png;
      
      public static var reward_track_locked_large:Class = locked_large_1_png;
      
      public static var reward_track_locked_reward:Class = locked_reward_1_png;
      
      public static var reward_track_locked_small:Class = locked_small_1_png;
      
      public static var reward_track_not_available_icon:Class = not_available_icon_1_png;
      
      public static var reward_track_point_large:Class = point_large_1_png;
      
      public static var reward_track_point_small:Class = point_small_1_png;
      
      public static var reward_track_premium_track:Class = premium_track_1_png;
      
      public static var reward_track_prizes_background:Class = prizes_background_1_png;
      
      public static var reward_track_prizes_background_stars:Class = prizes_background_stars_1_png;
      
      public static var reward_track_reward_gift:Class = reward_gift_1_png;
      
      public static var reward_track_reward_gift_premium:Class = reward_gift_premium_1_png;
      
      public static var reward_track_small_icon:Class = small_icon_1_png;
      
      public static var reward_track_task_list:Class = task_list_1_png;
      
      public static var reward_track_task_list_complete:Class = task_list_complete_1_png;
      
      public static var reward_track_tasks_buy_from_catalogue:Class = buy_from_catalogue_1_png;
      
      public static var reward_track_tasks_change_figure:Class = change_figure_1_png;
      
      public static var reward_track_tasks_change_motto:Class = change_motto_1_png;
      
      public static var reward_track_tasks_chat_with_someone:Class = chat_with_someone_1_png;
      
      public static var reward_track_tasks_create_room:Class = create_room_3_png;
      
      public static var reward_track_tasks_dance:Class = dance_1_png;
      
      public static var reward_track_tasks_enter_other_users_room:Class = enter_other_users_room_1_png;
      
      public static var reward_track_tasks_find_hand_item:Class = find_hand_item_1_png;
      
      public static var reward_track_tasks_follow_friend:Class = follow_friend_3_png;
      
      public static var reward_track_tasks_friend_furni_locked:Class = friend_furni_locked_1_png;
      
      public static var reward_track_tasks_give_respect:Class = give_respect_1_png;
      
      public static var reward_track_tasks_move_item:Class = move_item_1_png;
      
      public static var reward_track_tasks_pet_eat:Class = pet_eat_1_png;
      
      public static var reward_track_tasks_pet_level:Class = pet_level_1_png;
      
      public static var reward_track_tasks_pet_respect:Class = pet_respect_1_png;
      
      public static var reward_track_tasks_place_builders_club_furni:Class = place_builders_club_furni_1_png;
      
      public static var reward_track_tasks_place_item:Class = place_item_1_png;
      
      public static var reward_track_tasks_publish_picture:Class = publish_picture_1_png;
      
      public static var reward_track_tasks_replenish_respect:Class = replenish_respect_1_png;
      
      public static var reward_track_tasks_request_friend:Class = request_friend_1_png;
      
      public static var reward_track_tasks_rotate_item:Class = rotate_item_1_png;
      
      public static var reward_track_tasks_send_messenger_invite:Class = send_messenger_invite_1_png;
      
      public static var reward_track_tasks_send_messenger_message:Class = send_messenger_message_1_png;
      
      public static var reward_track_tasks_set_relationship_status:Class = set_relationship_status_1_png;
      
      public static var reward_track_tasks_switch_item_state:Class = switch_item_state_1_png;
      
      public static var reward_track_tasks_swim:Class = swim_1_png;
      
      public static var reward_track_tasks_teleport:Class = teleport_1_png;
      
      public static var reward_track_tasks_use_habbicon:Class = use_habbicon_1_png;
      
      public static var reward_track_tasks_wave:Class = wave_1_png;
      
      public static var reward_track_tasks_wear_badge:Class = wear_badge_1_png;
      
      public static var relationship_status_bobba:Class = bobba_1_png;
      
      public static var relationship_status_heart:Class = heart_2_png;
      
      public static var relationship_status_none:Class = none_1_png;
      
      public static var relationship_status_smile:Class = smile_1_png;
      
      public static var roomtools_achievements:Class = achievements_1_png;
      
      public static var roomtools_camera:Class = camera_2_png;
      
      public static var roomtools_chat_history:Class = chat_history_1_png;
      
      public static var roomtools_gear:Class = gear_1_png;
      
      public static var roomtools_history_back_bg:Class = history_back_bg_1_png;
      
      public static var roomtools_history_back_icon:Class = history_back_icon_1_png;
      
      public static var roomtools_history_forward_bg:Class = history_forward_bg_1_png;
      
      public static var roomtools_history_forward_icon:Class = history_forward_icon_1_png;
      
      public static var roomtools_history_open_bg:Class = history_open_bg_1_png;
      
      public static var roomtools_history_open_icon:Class = history_open_icon_1_png;
      
      public static var roomtools_like:Class = like_1_png;
      
      public static var roomtools_magnifier:Class = magnifier_1_png;
      
      public static var roomtools_minimizebutton:Class = minimizebutton_1_png;
      
      public static var roomtools_photo_icon:Class = photo_icon_1_png;
      
      public static var roomtools_unlike:Class = unlike_1_png;
      
      public static var roomtools_zoom_in:Class = zoom_in_1_png;
      
      public static var roomtools_zoom_out:Class = zoom_out_2_png;
      
      public static var talent_achieved_div:Class = achieved_div_1_png;
      
      public static var talent_achieved_left:Class = achieved_left_1_png;
      
      public static var talent_achieved_mid:Class = achieved_mid_1_png;
      
      public static var talent_achieved_right:Class = achieved_right_1_png;
      
      public static var talent_action_overlay:Class = action_overlay_1_png;
      
      public static var talent_avatar_glow:Class = avatar_glow_2_png;
      
      public static var talent_check_mark_circle:Class = check_mark_circle_1_png;
      
      public static var talent_citizenship_accomplished:Class = citizenship_accomplished_1_png;
      
      public static var talent_helper_icon:Class = icon_1_png;
      
      public static var talent_locked_achievement:Class = locked_achievement_1_png;
      
      public static var talent_locked_stripe:Class = locked_stripe_1_png;
      
      public static var talent_mask_left:Class = mask_left_1_png;
      
      public static var talent_mask_right:Class = mask_right_1_png;
      
      public static var talent_progress_lower:Class = progress_lower_1_png;
      
      public static var talent_progress_upper:Class = progress_upper_1_png;
      
      public static var talent_register_cutout_character:Class = register_cutout_character_1_png;
      
      public static var talent_task_progress_bg:Class = task_progress_bg_1_png;
      
      public static var talent_task_progress_fg:Class = task_progress_fg_1_png;
      
      public static var talent_task_progress_left:Class = task_progress_left_1_png;
      
      public static var talent_task_progress_right:Class = task_progress_right_1_png;
      
      public static var talent_unachieved_div:Class = unachieved_div_1_png;
      
      public static var talent_unachieved_left:Class = unachieved_left_1_png;
      
      public static var talent_unachieved_mid:Class = unachieved_mid_1_png;
      
      public static var talent_unachieved_right:Class = unachieved_right_1_png;
      
      public static var talent_vip_reward:Class = vip_reward_1_png;
      
      public static var toolbar_citizenship_icon:Class = citizenship_icon_1_png;
      
      public static var toolbar_credit_icon_0:Class = credit_icon_0_1_png;
      
      public static var toolbar_credit_icon_1:Class = credit_icon_1_1_png;
      
      public static var toolbar_credit_icon_2:Class = credit_icon_2_1_png;
      
      public static var toolbar_duckat_icon_0:Class = duckat_icon_0_1_png;
      
      public static var toolbar_duckat_icon_1:Class = duckat_icon_1_1_png;
      
      public static var toolbar_duckat_icon_2:Class = duckat_icon_2_1_png;
      
      public static var toolbar_hc_icon_0:Class = hc_icon_0_1_png;
      
      public static var toolbar_hc_icon_1:Class = hc_icon_1_1_png;
      
      public static var toolbar_hc_icon_2:Class = hc_icon_2_1_png;
      
      public static var toolbar_memenu_achievements_color:Class = achievements_color_2_png;
      
      public static var toolbar_memenu_achievements_white:Class = achievements_white_1_png;
      
      public static var toolbar_memenu_clothes_color:Class = clothes_color_2_png;
      
      public static var toolbar_memenu_clothes_white:Class = clothes_white_1_png;
      
      public static var toolbar_memenu_guide_color:Class = guide_color_1_png;
      
      public static var toolbar_memenu_guide_white:Class = guide_white_1_png;
      
      public static var toolbar_memenu_minimail_color:Class = minimail_color_2_png;
      
      public static var toolbar_memenu_minimail_white:Class = minimail_white_1_png;
      
      public static var toolbar_memenu_profile_color:Class = profile_color_2_png;
      
      public static var toolbar_memenu_profile_white:Class = profile_white_1_png;
      
      public static var toolbar_memenu_rooms_color:Class = rooms_color_1_png;
      
      public static var toolbar_memenu_rooms_white:Class = rooms_white_1_png;
      
      public static var toolbar_memenu_settings_color:Class = settings_color_1_png;
      
      public static var toolbar_memenu_settings_slider_base:Class = slider_base_1_png;
      
      public static var toolbar_memenu_settings_slider_button:Class = slider_button_1_png;
      
      public static var toolbar_memenu_settings_sounds_off_color:Class = sounds_off_color_2_png;
      
      public static var toolbar_memenu_settings_sounds_off_white:Class = sounds_off_white_1_png;
      
      public static var toolbar_memenu_settings_sounds_on_color:Class = sounds_on_color_1_png;
      
      public static var toolbar_memenu_settings_sounds_on_white:Class = sounds_on_white_1_png;
      
      public static var toolbar_memenu_settings_white:Class = settings_white_1_png;
      
      public static var toolbar_memenu_talents_color:Class = talents_color_1_png;
      
      public static var toolbar_memenu_talents_white:Class = talents_white_1_png;
      
      public static var toolbar_offer_icon_0:Class = offer_icon_0_1_png;
      
      public static var toolbar_offer_icon_1:Class = offer_icon_1_1_png;
      
      public static var toolbar_offer_icon_2:Class = offer_icon_2_1_png;
      
      public static var toolbar_room_icon_0:Class = room_icon_0_1_png;
      
      public static var toolbar_room_icon_1:Class = room_icon_1_1_png;
      
      public static var toolbar_room_icon_2:Class = room_icon_2_1_png;
      
      public static var tools_black_pixel:Class = black_pixel_1_png;
      
      public static var tools_file_icon:Class = file_icon_1_png;
      
      public static var tools_folder_icon:Class = folder_icon_1_png;
      
      public static var tools_tools_download_icon:Class = tools_download_icon_1_png;
      
      public static var unique_item_label_1:Class = label_1_1_png;
      
      public static var unique_item_label_glass_shine:Class = label_glass_shine_1_png;
      
      public static var unique_item_label_number_glyphs:Class = label_number_glyphs_1_png;
      
      public static var unique_item_label_plaque_border:Class = label_plaque_border_1_png;
      
      public static var unique_item_label_plaque_metal:Class = label_plaque_metal_1_png;
      
      public static var unique_item_label_studs:Class = label_studs_1_png;
      
      public static var unique_item_large_background_wide:Class = background_wide_1_png;
      
      public static var unique_item_large_glass_bottom:Class = glass_bottom_1_png;
      
      public static var unique_item_large_glass_mid:Class = glass_mid_1_png;
      
      public static var unique_item_large_glass_shine:Class = glass_shine_1_png;
      
      public static var unique_item_large_glass_top:Class = glass_top_1_png;
      
      public static var unique_item_large_iron:Class = iron_1_png;
      
      public static var unique_item_large_na_button:Class = na_button_1_png;
      
      public static var unique_item_large_na_button_wide:Class = na_button_wide_1_png;
      
      public static var unique_item_large_tile_upright:Class = tile_upright_1_png;
      
      public static var unique_item_sold_out_label:Class = sold_out_label_1_png;
      
      public static var unique_item_sold_out_tile:Class = sold_out_tile_1_png;
      
      public static var vault_earnings_icon_achievements:Class = earnings_icon_achievements_1_png;
      
      public static var vault_earnings_icon_bonusbag:Class = earnings_icon_bonusbag_1_png;
      
      public static var vault_earnings_icon_chests:Class = earnings_icon_chests_1_png;
      
      public static var vault_earnings_icon_games:Class = earnings_icon_games_1_png;
      
      public static var vault_earnings_icon_rpgs:Class = earnings_icon_rpgs_1_png;
      
      public static var vault_earnings_icon_dailygift:Class = earnings_icon_dailygift_1_png;
      
      public static var vault_earnings_icon_donations:Class = earnings_icon_donations_1_png;
      
      public static var vault_earnings_icon_hcpayday:Class = earnings_icon_hcpayday_1_png;
      
      public static var vault_earnings_icon_levelprogression:Class = earnings_icon_levelprogression_1_png;
      
      public static var vault_earnings_icon_marketplace:Class = earnings_icon_marketplace_1_png;
      
      public static var vault_earnings_icon_roombundle:Class = earnings_icon_roombundle_1_png;
      
      public static var vault_earnings_icon_snowstorm:Class = earnings_icon_snowstorm_1_png;
      
      public static var vault_earnings_icon_surprise:Class = earnings_icon_surprise_1_png;
      
      public static var vault_earnings_icon_tutorial:Class = earnings_icon_tutorial_1_png;
      
      public static var vault_icon_calendar:Class = icon_calendar_1_png;
      
      public static var vault_icon_earnings_cards:Class = icon_earnings_cards_1_png;
      
      public static var vault_icon_earnings_refresh_ads:Class = icon_earnings_refresh_ads_1_png;
      
      public static var vault_icon_earnings_trading_token:Class = icon_earnings_trading_token_1_png;
      
      public static var vault_icon_present:Class = icon_present_1_png;
      
      public static var vault_icon_vault_closed:Class = icon_vault_closed_1_png;
      
      public static var vault_icon_vault_open:Class = icon_vault_open_1_png;
      
      public static var vault_icon_vault_opener:Class = icon_vault_opener_1_png;
      
      public static var wired_chests_bell_icon:Class = bell_icon_1_png;
      
      public static var wired_chests_gear_icon:Class = gear_icon_1_png;
      
      public static var wired_chests_icons_payments_game_entrance_icon:Class = payments_game_entrance_icon_1_png;
      
      public static var wired_chests_icons_payments_life_icon:Class = payments_life_icon_1_png;
      
      public static var wired_chests_icons_payments_tickets_icon:Class = payments_tickets_icon_1_png;
      
      public static var wired_chests_images_classic_furni_chest_empty:Class = classic_furni_chest_empty_1_png;
      
      public static var wired_chests_images_dark_coins_chest_balance_high:Class = dark_coins_chest_balance_high_1_png;
      
      public static var wired_chests_images_dark_coins_chest_balance_low:Class = dark_coins_chest_balance_low_1_png;
      
      public static var wired_chests_images_dark_coins_chest_balance_medium:Class = dark_coins_chest_balance_medium_1_png;
      
      public static var wired_chests_images_dark_coins_chest_balance_zero:Class = dark_coins_chest_balance_zero_1_png;
      
      public static var wired_chests_images_games_payments:Class = games_payments_1_png;
      
      public static var wired_chests_images_generic_payments:Class = generic_payments_1_png;
      
      public static var wired_chests_images_light_coins_chest_balance_high:Class = light_coins_chest_balance_high_1_png;
      
      public static var wired_chests_images_light_coins_chest_balance_low:Class = light_coins_chest_balance_low_1_png;
      
      public static var wired_chests_images_light_coins_chest_balance_medium:Class = light_coins_chest_balance_medium_1_png;
      
      public static var wired_chests_images_light_coins_chest_balance_zero:Class = light_coins_chest_balance_zero_1_png;
      
      public static var wired_chests_images_variant_furni_chest_empty:Class = variant_furni_chest_empty_1_png;
      
      public static var wired_add:Class = add_1_png;
      
      public static var wired_reference:Class = reference_1_png;
      
      public static var wired_reduce_image:Class = reduce_image_1_png;
      
      public static var wired_enlarge_image:Class = enlarge_image_1_png;
      
      public static var wired_remove:Class = remove_1_png;
      
      public static var wired_volter_uparrow:Class = uparrow_1_png;
      
      public static var wired_volter_downarrow:Class = downarrow_1_png;
      
      public static var var_picker_all:Class = var_picker_all_1_png;
      
      public static var var_picker_internal:Class = var_picker_internal_1_png;
      
      public static var var_picker_recent:Class = var_picker_recent_1_png;
      
      public static var var_picker_search:Class = var_picker_search_1_png;
      
      public static var var_picker_smart:Class = var_picker_smart_1_png;
      
      public static var var_picker_usermade:Class = var_picker_usermade_1_png;
      
      public static var var_picker_cancel_search:Class = var_picker_cancel_search_1_png;
      
      public static var wired_type_icons_icon_action:Class = icon_action_1_png;
      
      public static var wired_type_icons_icon_addon:Class = icon_addon_1_png;
      
      public static var wired_type_icons_icon_condition:Class = icon_condition_1_png;
      
      public static var wired_type_icons_icon_selector:Class = icon_selector_2_png;
      
      public static var wired_type_icons_icon_trigger:Class = icon_trigger_2_png;
      
      public static var wired_type_icons_icon_variable:Class = icon_variable_2_png;
      
      public static var wired_styles_volter_furni_picks_1:Class = furni_picks_1_2_png;
      
      public static var wired_styles_volter_furni_picks_2:Class = furni_picks_2_1_png;
      
      public static var wired_styles_volter_move_0:Class = move_0_2_png;
      
      public static var wired_styles_volter_move_1:Class = move_1_1_png;
      
      public static var wired_styles_volter_move_2:Class = move_2_1_png;
      
      public static var wired_styles_volter_move_3:Class = move_3_1_png;
      
      public static var wired_styles_volter_move_4:Class = move_4_1_png;
      
      public static var wired_styles_volter_move_5:Class = move_5_3_png;
      
      public static var wired_styles_volter_move_6:Class = move_6_2_png;
      
      public static var wired_styles_volter_move_7:Class = move_7_1_png;
      
      public static var wired_styles_volter_move_diag:Class = move_diag_3_png;
      
      public static var wired_styles_volter_move_rnd:Class = move_rnd_2_png;
      
      public static var wired_styles_volter_move_vrt:Class = move_vrt_3_png;
      
      public static var wired_styles_volter_rotate_ccw:Class = rotate_ccw_1_png;
      
      public static var wired_styles_volter_rotate_cw:Class = rotate_cw_1_png;
      
      public static var wired_styles_volter_slider_bg:Class = slider_bg_1_png;
      
      public static var wired_styles_volter_slider_obj:Class = slider_obj_1_png;
      
      public static var wired_styles_illumina_slider_obj:Class = slider_obj_2_png;
      
      public static var wired_styles_illumina_furni_picks_1:Class = furni_picks_1_1_png;
      
      public static var wired_styles_illumina_furni_picks_2:Class = furni_picks_2_2_png;
      
      public static var wired_styles_illumina_move_0:Class = move_0_3_png;
      
      public static var wired_styles_illumina_move_1:Class = move_1_3_png;
      
      public static var wired_styles_illumina_move_2:Class = move_2_4_png;
      
      public static var wired_styles_illumina_move_3:Class = move_3_4_png;
      
      public static var wired_styles_illumina_move_4:Class = move_4_3_png;
      
      public static var wired_styles_illumina_move_5:Class = move_5_2_png;
      
      public static var wired_styles_illumina_move_6:Class = move_6_1_png;
      
      public static var wired_styles_illumina_move_7:Class = move_7_3_png;
      
      public static var wired_styles_illumina_move_diag:Class = move_diag_2_png;
      
      public static var wired_styles_illumina_move_rnd:Class = move_rnd_3_png;
      
      public static var wired_styles_illumina_move_vrt:Class = move_vrt_1_png;
      
      public static var wired_styles_illumina_rotate_ccw:Class = rotate_ccw_3_png;
      
      public static var wired_styles_illumina_rotate_cw:Class = rotate_cw_2_png;
      
      public static var wired_styles_illumina_icon_source_furni:Class = icon_source_furni_1_png;
      
      public static var wired_styles_illumina_icon_source_users:Class = icon_source_users_1_png;
      
      public static var wired_styles_illumina_icon_source_global:Class = icon_source_global_1_png;
      
      public static var wired_styles_illumina_icon_source_context:Class = icon_source_context_1_png;
      
      public static var word_quiz_thum_down:Class = thum_down_1_png;
      
      public static var word_quiz_thum_down_big:Class = thum_down_big_1_png;
      
      public static var word_quiz_thum_up:Class = thum_up_1_png;
      
      public static var word_quiz_thum_up_big:Class = thum_up_big_1_png;
      
      public static var avatar_image_xml:Class = avatar_image_2_xml;
      
      public static var badge_image_xml:Class = badge_image_1_xml;
      
      public static var balloon_xml:Class = balloon_1_xml;
      
      public static var clock_base_xml:Class = clock_base_1_xml;
      
      public static var hover_bitmap_xml:Class = hover_bitmap_1_xml;
      
      public static var illumina_border_xml:Class = illumina_border_1_xml;
      
      public static var illumina_chat_bubble_xml:Class = illumina_chat_bubble_1_xml;
      
      public static var illumina_input_xml:Class = illumina_input_1_xml;
      
      public static var product_icon_xml:Class = product_icon_1_xml;
      
      public static var product_image_xml:Class = product_image_1_xml;
      
      public static var updating_timestamp_xml:Class = updating_timestamp_1_xml;
      
      public static var progress_indicator_xml:Class = progress_indicator_1_xml;
      
      public static var separator_xml:Class = separator_1_xml;
      
      public static var running_number_xml:Class = running_number_1_xml;
      
      public static var pet_image_xml:Class = pet_image_1_xml;
      
      public static var furniture_image_xml:Class = furniture_image_1_xml;
      
      public static var room_previewer_xml:Class = room_previewer_1_xml;
      
      public static var pixel_limit_xml:Class = pixel_limit_1_xml;
      
      public static var room_usercount_xml:Class = room_usercount_1_xml;
      
      public static var room_thumbnail_xml:Class = room_thumbnail_1_xml;
      
      public static var illumina_chat_bubble_text_xml:Class = illumina_chat_bubble_text_1_xml;
      
      public static var unique_item_overlay_griditem_xml:Class = unique_item_overlay_griditem_1_xml;
      
      public static var unique_item_overlay_supply_xml:Class = unique_item_overlay_supply_1_xml;
      
      public static var unique_item_overlay_preview_xml:Class = unique_item_overlay_preview_1_xml;
      
      public static var rarity_item_overlay_griditem_xml:Class = rarity_item_overlay_griditem_1_xml;
      
      public static var rarity_item_overlay_preview_xml:Class = rarity_item_overlay_preview_1_xml;
      
      public static var table_view_xml:Class = table_view_1_xml;
      
      public static var chest_overlay_griditem_xml:Class = chest_overlay_griditem_1_xml;
      
      public static var icon_wired_variable_user_large_png:Class = icon_wired_variable_user_large_1_png;
      
      public static var icon_wired_variable_context_large_png:Class = icon_wired_variable_context_large_1_png;
      
      public static var icon_wired_variable_global_large_png:Class = icon_wired_variable_global_large_1_png;
      
      public static var icon_wired_variable_furni_large_png:Class = icon_wired_variable_furni_large_1_png;
      
      public static var icon_wired_error_png:Class = icon_wired_error_1_png;
      
      public static var icon_wired_notification_png:Class = icon_wired_notification_2_png;
      
      public static var icon_wired_warning_png:Class = icon_wired_warning_2_png;
      
      public static var icon_discord_png:Class = icon_discord_1_png;
      
      public static var wired_box_lines_png:Class = wired_box_lines_1_png;
      
      public static var wired_global_placeholder_png:Class = wired_global_placeholder_1_png;
      
      public static var wired_monitor_element1_png:Class = wired_monitor_element1_1_png;
      
      public static var wired_monitor_element2_png:Class = wired_monitor_element2_1_png;
      
      public static var wired_misc_directional_system_0_png:Class = directional_system_0_1_png;
      
      public static var wired_misc_directional_system_1_png:Class = directional_system_1_1_png;
      
      public static var wired_misc_directional_system_2_png:Class = directional_system_2_1_png;
      
      public static var wired_misc_directional_system_3_png:Class = directional_system_3_1_png;
      
      public static var recycler_furnimatic_indicator_pointer_base:Class = furnimatic_indicator_pointer_base_1_png;
      
      public static var recycler_furnimatic_indicator_pointer_arrow:Class = furnimatic_indicator_pointer_arrow_1_png;
      
      public static var recycler_furnimatic_indicator:Class = furnimatic_indicator_1_png;
      
      public static var recycler_furnimatic_container_right:Class = furnimatic_container_right_1_png;
      
      public static var recycler_furnimatic_container_slice:Class = furnimatic_container_slice_1_png;
      
      public static var recycler_furnimatic_container_left:Class = furnimatic_container_left_1_png;
      
      public static var recycler_furnimatic_machine:Class = furnimatic_machine_1_png;
      
      public static var recycler_furnimatic_title:Class = furnimatic_title_1_png;
      
      public static var recycler_recycler_icon:Class = recycler_icon_1_png;
      
      public static var special_items_item_platform:Class = item_platform_1_png;
      
      public static var special_items_spotlight1:Class = spotlight1_1_png;
      
      public static var special_items_spotlight2:Class = spotlight2_1_png;
      
      public static var badge_rarity_badges_emblem:Class = badges_emblem_1_png;
      
      public static var badge_rarity_badges_emblem_uncommon:Class = badges_emblem_uncommon_1_png;
      
      public static var badge_rarity_badges_emblem_uncommon_extended:Class = badges_emblem_uncommon_extended_1_png;
      
      public static var badge_rarity_badges_emblem_rare:Class = badges_emblem_rare_1_png;
      
      public static var badge_rarity_badges_emblem_rare_extended:Class = badges_emblem_rare_extended_1_png;
      
      public static var badge_rarity_badges_emblem_very_rare:Class = badges_emblem_very_rare_1_png;
      
      public static var badge_rarity_badges_emblem_very_rare_extended:Class = badges_emblem_very_rare_extended_1_png;
      
      public static var badge_rarity_badges_emblem_mythical:Class = badges_emblem_mythical_1_png;
      
      public static var badge_rarity_badges_emblem_mythical_extended:Class = badges_emblem_mythical_extended_1_png;
      
      public static var badge_rarity_badges_emblem_legendary:Class = badges_emblem_legendary_1_png;
      
      public static var badge_rarity_badges_emblem_legendary_extended:Class = badges_emblem_legendary_extended_1_png;
      
      public static var badge_rarity_badges_emblem_unique:Class = badges_emblem_unique_1_png;
      
      public static var badge_rarity_badges_emblem_unique_extended:Class = badges_emblem_unique_extended_1_png;
      
      public static var badges_emblem_achievement:Class = badges_emblem_achievement_1_png;
      
      public static var badges_emblem_achievement_extended:Class = badges_emblem_achievement_extended_1_png;
      
      public static var badge_leaderboard_entry_even:Class = entry_even_1_png;
      
      public static var badge_leaderboard_entry_self:Class = entry_self_1_png;
      
      public static var badge_leaderboard_entry_uneven:Class = entry_uneven_1_png;
      
      public static var badge_leaderboard_header:Class = header_1_png;
      
      public static var badge_leaderboard_dropdown_opener:Class = dropdown_opener_1_png;
      
      public static var star_small_grey:Class = small_grey_1_png;
      
      public static var star_small_green:Class = small_green_1_png;
      
      public static var star_small_pink:Class = small_pink_1_png;
      
      public static var star_small_diamond:Class = small_diamond_1_png;
      
      public static var star_small_ruby:Class = small_ruby_1_png;
      
      public static var star_small_gold:Class = small_gold_1_png;
      
      public static var star_small_silver:Class = small_silver_1_png;
      
      public static var star_small_bronze:Class = small_bronze_1_png;
      
      public function HabboWindowManagerCom()
      {
         super();
      }
   }
}

