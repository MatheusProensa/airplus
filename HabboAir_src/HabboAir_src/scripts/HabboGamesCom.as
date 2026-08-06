package
{
   import com.sulake.bootstrap.HabboGameManagerBootstrap;
   import com.sulake.iid.IIDHabboGameManager;
   import mx.core.SimpleApplication;
   
   [SecureSWF(rename="false")]
   public class HabboGamesCom extends SimpleApplication
   {
      private static var _logEnabled:Boolean = true;
      
      public static var manifest:Class = manifest_27_xml;
      
      public static const explosion0001:Class = explosion0001_1_png;
      
      public static const explosion0002:Class = explosion0002_1_png;
      
      public static const explosion0003:Class = explosion0003_1_png;
      
      public static const explosion0004:Class = explosion0004_1_png;
      
      public static const explosion0005:Class = explosion0005_1_png;
      
      public static const explosion0006:Class = explosion0006_1_png;
      
      public static const explosion0007:Class = explosion0007_1_png;
      
      public static const explosion0008:Class = explosion0008_1_png;
      
      public static const explosion0009:Class = explosion0009_1_png;
      
      public static const explosion0010:Class = explosion0010_1_png;
      
      public static const explosion0011:Class = explosion0011_1_png;
      
      public static const explosion0012:Class = explosion0012_1_png;
      
      public static const hc_icon:Class = hc_icon_2_png;
      
      public static const btn_more_games_10:Class = btn_more_games_10_1_png;
      
      public static const btn_more_games_10_hi:Class = btn_more_games_10_hi_1_png;
      
      public static const btn_more_games_100:Class = btn_more_games_100_1_png;
      
      public static const btn_more_games_100_hi:Class = btn_more_games_100_hi_1_png;
      
      public static const btn_more_games_300:Class = btn_more_games_300_1_png;
      
      public static const btn_more_games_300_hi:Class = btn_more_games_300_hi_1_png;
      
      public static const bg_sky:Class = bg_sky_1_png;
      
      public static const bg_sunshine:Class = bg_sunshine_1_png;
      
      public static const bg_vista_1:Class = bg_vista_1_1_png;
      
      public static const bg_vista_2:Class = bg_vista_2_1_png;
      
      public static const bg_vista_3:Class = bg_vista_3_1_png;
      
      public static const blue_ball:Class = blue_ball_1_png;
      
      public static const blue_ball_rematch:Class = blue_ball_rematch_1_png;
      
      public static const blue_glove:Class = blue_glove_1_png;
      
      public static const blue_infobox:Class = blue_infobox_1_png;
      
      public static const blue_square:Class = blue_square_1_png;
      
      public static const gray_ball:Class = gray_ball_1_png;
      
      public static const gray_infobox:Class = gray_infobox_1_png;
      
      public static const gray_square:Class = gray_square_1_png;
      
      public static const green_square:Class = green_square_1_png;
      
      public static const load_1:Class = load_1_1_png;
      
      public static const load_2:Class = load_2_1_png;
      
      public static const load_3:Class = load_3_1_png;
      
      public static const load_4:Class = load_4_1_png;
      
      public static const load_5:Class = load_5_1_png;
      
      public static const load_6:Class = load_6_1_png;
      
      public static const load_7:Class = load_7_1_png;
      
      public static const load_8:Class = load_8_1_png;
      
      public static const red_ball:Class = red_ball_1_png;
      
      public static const red_ball_rematch:Class = red_ball_rematch_1_png;
      
      public static const red_glove:Class = red_glove_1_png;
      
      public static const red_infobox:Class = red_infobox_1_png;
      
      public static const red_square:Class = red_square_1_png;
      
      public static const snowstorm_logo:Class = snowstorm_logo_1_png;
      
      public static const ui_ball_indicator_bg:Class = ui_ball_indicator_bg_1_png;
      
      public static const ui_ball:Class = ui_ball_1_png;
      
      public static const ui_exit_down:Class = ui_exit_down_1_png;
      
      public static const ui_exit_up:Class = ui_exit_up_1_png;
      
      public static const ui_make_balls_down:Class = ui_make_balls_down_1_png;
      
      public static const ui_make_balls_up:Class = ui_make_balls_up_1_png;
      
      public static const ui_me_bg:Class = ui_me_bg_1_png;
      
      public static const rematch_1:Class = rematch_1_1_png;
      
      public static const rematch_2:Class = rematch_2_1_png;
      
      public static const rematch_3:Class = rematch_3_1_png;
      
      public static const rematch_4:Class = rematch_4_1_png;
      
      public static const rematch_5:Class = rematch_5_1_png;
      
      public static const rematch_6:Class = rematch_6_1_png;
      
      public static const ui_me_health_0:Class = ui_me_health_0_1_png;
      
      public static const ui_me_health_1:Class = ui_me_health_1_1_png;
      
      public static const ui_me_health_2:Class = ui_me_health_2_1_png;
      
      public static const ui_me_health_3:Class = ui_me_health_3_1_png;
      
      public static const ui_me_health_4:Class = ui_me_health_4_1_png;
      
      public static const ui_me_health_5:Class = ui_me_health_5_1_png;
      
      public static const ui_me_minus_1:Class = ui_me_minus_1_1_png;
      
      public static const ui_me_minus_2:Class = ui_me_minus_2_1_png;
      
      public static const ui_me_minus_3:Class = ui_me_minus_3_1_png;
      
      public static const ui_me_minus_4:Class = ui_me_minus_4_1_png;
      
      public static const ui_me_plus_1:Class = ui_me_plus_1_1_png;
      
      public static const ui_me_plus_2:Class = ui_me_plus_2_1_png;
      
      public static const ui_me_plus_3:Class = ui_me_plus_3_1_png;
      
      public static const ui_me_plus_4:Class = ui_me_plus_4_1_png;
      
      public static const ui_no_balls_1:Class = ui_no_balls_1_1_png;
      
      public static const ui_no_balls_2:Class = ui_no_balls_2_1_png;
      
      public static const ui_no_balls_3:Class = ui_no_balls_3_1_png;
      
      public static const ui_no_balls_4:Class = ui_no_balls_4_1_png;
      
      public static const ui_timer_and_points:Class = ui_timer_and_points_1_png;
      
      public static const arena_8_preview:Class = arena_8_preview_1_png;
      
      public static const arena_9_preview:Class = arena_9_preview_1_png;
      
      public static const arena_10_preview:Class = arena_10_preview_1_png;
      
      public static const arena_11_preview:Class = arena_11_preview_1_png;
      
      public static const arena_12_preview:Class = arena_12_preview_1_png;
      
      public static const star_empty:Class = star_empty_1_png;
      
      public static const star_filled_bronze:Class = star_filled_bronze_1_png;
      
      public static const star_filled_silver:Class = star_filled_silver_1_png;
      
      public static const star_filled_gold:Class = star_filled_gold_1_png;
      
      public static const quick_play_background:Class = quick_play_background_1_png;
      
      public static const quick_play_instructions:Class = quick_play_instructions_1_png;
      
      public static const quick_play_teaser:Class = quick_play_teaser_1_png;
      
      public static const free_games_bg:Class = free_games_bg_1_png;
      
      public static const leaderboard_bg:Class = leaderboard_bg_1_png;
      
      public static const leaderboard_divider:Class = leaderboard_divider_1_png;
      
      public static const leaderboard_highlighter:Class = leaderboard_highlighter_1_png;
      
      public static const left_black:Class = left_black_1_png;
      
      public static const left_blue:Class = left_blue_1_png;
      
      public static const right_black:Class = right_black_1_png;
      
      public static const right_blue:Class = right_blue_1_png;
      
      public static const add_friend_icon_blue:Class = add_friend_icon_blue_1_png;
      
      public static const add_friend_icon_red:Class = add_friend_icon_red_1_png;
      
      public static const add_friend_icon_green:Class = add_friend_icon_green_1_png;
      
      public static const scroll_down_normal:Class = scroll_down_normal_1_png;
      
      public static const scroll_down_click:Class = scroll_down_click_1_png;
      
      public static const scroll_down_hilite:Class = scroll_down_hilite_1_png;
      
      public static const scroll_down_inactive:Class = scroll_down_inactive_1_png;
      
      public static const scroll_up_normal:Class = scroll_up_normal_1_png;
      
      public static const scroll_up_click:Class = scroll_up_click_1_png;
      
      public static const scroll_up_hilite:Class = scroll_up_hilite_1_png;
      
      public static const scroll_up_inactive:Class = scroll_up_inactive_1_png;
      
      public static const scroll_left:Class = scroll_left_1_png;
      
      public static const scroll_right:Class = scroll_right_1_png;
      
      public static const throw_1_1:Class = throw_1_1_1_png;
      
      public static const throw_1_2:Class = throw_1_2_1_png;
      
      public static const throw_1_3:Class = throw_1_3_1_png;
      
      public static const throw_1_4:Class = throw_1_4_1_png;
      
      public static const throw_2_1:Class = throw_2_1_1_png;
      
      public static const throw_2_2:Class = throw_2_2_1_png;
      
      public static const throw_2_3:Class = throw_2_3_1_png;
      
      public static const throw_2_4:Class = throw_2_4_1_png;
      
      public static const throw_2_5:Class = throw_2_5_1_png;
      
      public static const throw_3_1:Class = throw_3_1_1_png;
      
      public static const throw_3_2:Class = throw_3_2_1_png;
      
      public static const throw_3_3:Class = throw_3_3_1_png;
      
      public static const throw_3_4:Class = throw_3_4_1_png;
      
      public static const throw_3_5:Class = throw_3_5_1_png;
      
      public static const balls_1:Class = balls_1_1_png;
      
      public static const balls_2:Class = balls_2_1_png;
      
      public static const balls_3:Class = balls_3_1_png;
      
      public static const balls_4:Class = balls_4_1_png;
      
      public static const balls_5:Class = balls_5_1_png;
      
      public static const move_1:Class = move_1_2_png;
      
      public static const move_2:Class = move_2_3_png;
      
      public static const move_3:Class = move_3_3_png;
      
      public static const move_4:Class = move_4_2_png;
      
      public static const pagination_ball:Class = pagination_ball_1_png;
      
      public static const pagination_ball_hilite:Class = pagination_ball_hilite_1_png;
      
      public static const games_main:Class = games_main_1_xml;
      
      public static const instructions_list_item:Class = instructions_list_item_1_xml;
      
      public static const counter:Class = counter_1_xml;
      
      public static const figure:Class = figure_1_xml;
      
      public static const snowwar_ending:Class = snowwar_ending_1_xml;
      
      public static const snowwar_exit:Class = snowwar_exit_1_xml;
      
      public static const snowwar_lobby_player:Class = snowwar_lobby_player_1_xml;
      
      public static const snowwar_lobby_player_team_1:Class = snowwar_lobby_player_team_1_1_xml;
      
      public static const snowwar_lobby_player_team_2:Class = snowwar_lobby_player_team_2_1_xml;
      
      public static const snowwar_results_player_team_1:Class = snowwar_results_player_team_1_1_xml;
      
      public static const snowwar_results_player_team_2:Class = snowwar_results_player_team_2_1_xml;
      
      public static const snowwar_own_stats:Class = snowwar_own_stats_1_xml;
      
      public static const snowwar_snowballs:Class = snowwar_snowballs_1_xml;
      
      public static const snowwar_team_scores:Class = snowwar_team_scores_1_xml;
      
      public static const snowwar_timer:Class = snowwar_timer_1_xml;
      
      public static var snowwar_loading_background_xml:Class = snowwar_loading_background_1_xml;
      
      public static var snowwar_exit_confirmation:Class = snowwar_exit_confirmation_1_xml;
      
      public static var snowwar_leaderboard:Class = snowwar_leaderboard_1_xml;
      
      public static var snowwar_leaderboard_entry:Class = snowwar_leaderboard_entry_1_xml;
      
      public static var requiredClasses:Array = new Array(HabboGameManagerBootstrap,IIDHabboGameManager);
      
      public function HabboGamesCom()
      {
         super();
      }
      
      public static function set logEnabled(param1:Boolean) : void
      {
         _logEnabled = param1;
      }
      
      public static function get logEnabled() : Boolean
      {
         return false;
      }
      
      public static function log(... rest) : void
      {
      }
   }
}

