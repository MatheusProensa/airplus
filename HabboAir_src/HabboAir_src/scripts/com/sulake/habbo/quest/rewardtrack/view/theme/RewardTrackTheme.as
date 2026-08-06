package com.sulake.habbo.quest.rewardtrack.view.theme
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   
   public class RewardTrackTheme
   {
      private static const BLUE:String = "blue";
      
      private static const ORANGE:String = "orange";
      
      private static const FOREST_GREEN:String = "forest_green";
      
      private static const RED:String = "red";
      
      private static const CYAN:String = "cyan";
      
      private static const RECOLORABLE_LIGHT:String = "RECOLORABLE_LIGHT";
      
      private static const RECOLORABLE_MEDIUM:String = "RECOLORABLE_MEDIUM";
      
      private static const RECOLORABLE_DARK:String = "RECOLORABLE_DARK";
      
      private var _key:String;
      
      private var _darkColor:uint;
      
      private var _mediumColor:uint;
      
      private var _lightColor:uint;
      
      private var _activeColor:uint;
      
      public function RewardTrackTheme(param1:String, param2:uint, param3:uint, param4:uint, param5:uint)
      {
         super();
         _key = param1;
         _darkColor = param2;
         _mediumColor = param3;
         _lightColor = param4;
         _activeColor = param5;
      }
      
      public static function resolve(param1:String) : RewardTrackTheme
      {
         switch(param1)
         {
            case "orange":
               return new RewardTrackTheme("orange",13203736,16768946,16773078,16764817);
            case "forest_green":
               return new RewardTrackTheme("forest_green",4164165,13494987,14808031,12115894);
            case "red":
               return new RewardTrackTheme("red",12077899,15846604,16309725,15186104);
            case "cyan":
               return new RewardTrackTheme("cyan",2072243,13103093,14481403,11921905);
            default:
               return new RewardTrackTheme("blue",3503801,13624057,14543865,12441327);
         }
      }
      
      public function applyTo(param1:IWindowModel) : void
      {
         var _loc2_:IWindowController_1 = null;
         var _loc3_:int = 0;
         applyColor(param1);
         if(param1 is IWindowController_1)
         {
            _loc2_ = param1 as IWindowController_1;
            _loc3_ = 0;
            while(_loc3_ < _loc2_.numChildren)
            {
               applyTo(_loc2_.getChildAt(_loc3_));
               _loc3_ += 1;
            }
         }
      }
      
      private function applyColor(param1:IWindowModel) : void
      {
         if(param1.tags.indexOf("RECOLORABLE_LIGHT") >= 0)
         {
            param1.color = _lightColor;
         }
         else if(param1.tags.indexOf("RECOLORABLE_MEDIUM") >= 0)
         {
            param1.color = _mediumColor;
         }
         else if(param1.tags.indexOf("RECOLORABLE_DARK") >= 0)
         {
            param1.color = _darkColor;
         }
      }
      
      public function get key() : String
      {
         return _key;
      }
      
      public function get darkColor() : uint
      {
         return _darkColor;
      }
      
      public function get lightColor() : uint
      {
         return _lightColor;
      }
      
      public function get activeColor() : uint
      {
         return _activeColor;
      }
   }
}

