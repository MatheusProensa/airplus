package com.sulake.habbo.ui.widget.camera
{
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.utils.StringUtil;
   import flash.filters.BitmapFilter;
   import flash.filters.ColorMatrixFilter;
   
   public class CameraEffect
   {
      private static const DEFAULT_EFFECT_STRENGTH:Number = 0.5;
      
      public static const TYPE_COLORMATRIX:String = "colormatrix";
      
      public static const UnknownConstFromCameraEffect_String_1:String = "composite";
      
      public static const TYPE_FRAME:String = "frame";
      
      private static var UnknownVarFromCameraEffect_Map_1:Map;
      
      private static var UnknownVarFromCameraEffect_Int_1:int = 1;
      
      private static var UnknownVarFromCameraEffect_IHabboLocalizationManager_1:IHabboLocalizationManager;
      
      private static var _availableEffectNames:Array = [];
      
      public var type:String;
      
      public var matrixArray:Array;
      
      public var blendmode:String;
      
      public var name:String;
      
      public var description:String;
      
      public var value:int;
      
      public var isOn:Boolean = false;
      
      public var achievementLevel:int = 0;
      
      public var button:IWindowController_1;
      
      public function CameraEffect(param1:String, param2:String, param3:Array, param4:String, param5:int)
      {
         super();
         this.name = param1;
         this.description = UnknownVarFromCameraEffect_IHabboLocalizationManager_1.getLocalization("camera.effect.name." + param1,param1);
         this.type = param2;
         this.blendmode = param4;
         this.matrixArray = param3;
         this.achievementLevel = param5;
      }
      
      public static function resetAllEffects() : void
      {
         for each(var _loc1_ in UnknownVarFromCameraEffect_Map_1)
         {
            _loc1_.value = 0.5 * UnknownVarFromCameraEffect_Int_1;
            _loc1_.setChosen(false);
         }
      }
      
      public static function setMaxValue(param1:int) : void
      {
         UnknownVarFromCameraEffect_Int_1 = param1;
      }
      
      public static function getEffects(param1:String, param2:IHabboLocalizationManager) : Map
      {
         var _loc3_:Array = null;
         if(!UnknownVarFromCameraEffect_Map_1)
         {
            if(param1 != null)
            {
               _loc3_ = param1.split(",");
               for each(var _loc4_ in _loc3_)
               {
                  _availableEffectNames.push(StringUtil.trim(_loc4_));
               }
            }
            UnknownVarFromCameraEffect_IHabboLocalizationManager_1 = param2;
            initEffects();
         }
         return UnknownVarFromCameraEffect_Map_1;
      }
      
      private static function initEffects() : void
      {
         UnknownVarFromCameraEffect_Map_1 = new Map();
         addEffect("dark_sepia","colormatrix",[0.4,0.4,0.1,0,110,0.3,0.4,0.1,0,30,0.3,0.2,0.1,0,0,0,0,0,1,0],null);
         addEffect("increase_saturation","colormatrix",[2,-0.5,-0.5,0,0,-0.5,2,-0.5,0,0,-0.5,-0.5,2,0,0,0,0,0,1,0],null);
         addEffect("increase_contrast","colormatrix",[1.5,0,0,0,-50,0,1.5,0,0,-50,0,0,1.5,0,-50,0,0,0,1.5,0],null);
         addEffect("shadow_multiply_02","composite",null,"multiply");
         addEffect("color_1","colormatrix",[0.393,0.769,0.189,0,0,0.349,0.686,0.168,0,0,0.272,0.534,0.131,0,0,0,0,0,1,0],null,1);
         addEffect("hue_bright_sat","colormatrix",[1,0.6,0.2,0,-50,0.2,1,0.6,0,-50,0.6,0.2,1,0,-50,0,0,0,1,0],null,1);
         addEffect("hearts_hardlight_02","composite",null,"hardlight",1);
         addEffect("texture_overlay","composite",null,"overlay",1);
         addEffect("pinky_nrm","composite",null,"normal",1);
         addEffect("color_2","colormatrix",[0.333,0.333,0.333,0,0,0.333,0.333,0.333,0,0,0.333,0.333,0.333,0,0,0,0,0,1,0],null,2);
         addEffect("night_vision","colormatrix",[0,0,0,0,0,0,1.1,0,0,-50,0,0,0,0,0,0,0,0,1,0],null,2);
         addEffect("stars_hardlight_02","composite",null,"hardlight",2);
         addEffect("coffee_mpl","composite",null,"multiply",2);
         addEffect("security_hardlight","composite",null,"hardlight",3);
         addEffect("bluemood_mpl","composite",null,"multiply",3);
         addEffect("rusty_mpl","composite",null,"multiply",3);
         addEffect("decr_conrast","colormatrix",[0.5,0,0,0,50,0,0.5,0,0,50,0,0,0.5,0,50,0,0,0,1,0],null,4);
         addEffect("green_2","colormatrix",[0.5,0.5,0.5,0,0,0.5,0.5,0.5,0,90,0.5,0.5,0.5,0,0,0,0,0,1,0],null,4);
         addEffect("alien_hrd","composite",null,"hardlight",4);
         addEffect("color_3","colormatrix",[0.609,0.609,0.082,0,0,0.309,0.609,0.082,0,0,0.309,0.609,0.082,0,0,0,0,0,1,0],null,5);
         addEffect("color_4","colormatrix",[0.8,-0.8,1,0,70,0.8,-0.8,1,0,70,0.8,-0.8,1,0,70,0,0,0,1,0],null,5);
         addEffect("toxic_hrd","composite",null,"hardlight",5);
         addEffect("hypersaturated","colormatrix",[2,-1,0,0,0,-1,2,0,0,0,0,-1,2,0,0,0,0,0,1,0],null,6);
         addEffect("Yellow","colormatrix",[1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0],null,6);
         addEffect("misty_hrd","composite",null,"hardlight",6);
         addEffect("x_ray","colormatrix",[0,1.2,0,0,-100,0,2,0,0,-120,0,2,0,0,-120,0,0,0,1,0],null,7);
         addEffect("decrease_saturation","colormatrix",[0.7,0.2,0.2,0,0,0.2,0.7,0.2,0,0,0.2,0.2,0.7,0,0,0,0,0,1,0],null,7);
         addEffect("drops_mpl","composite",null,"multiply",8);
         addEffect("shiny_hrd","composite",null,"hardlight",9);
         addEffect("glitter_hrd","composite",null,"hardlight",10);
         addEffect("frame_gold","frame",null,null,999);
         addEffect("frame_gray_4","frame",null,null,999);
         addEffect("frame_black_2","frame",null,null,999);
         addEffect("frame_wood_2","frame",null,null,999);
         addEffect("finger_nrm","frame",null,null,999);
         addEffect("color_5","colormatrix",[3.309,0.609,1.082,0.2,0,0.309,0.609,0.082,0,0,1.309,0.609,0.082,0,0,0,0,0,1,0],null,999);
         addEffect("black_white_negative","colormatrix",[-0.5,-0.5,-0.5,0,255,-0.5,-0.5,-0.5,0,255,-0.5,-0.5,-0.5,0,255,0,0,0,1,0],null,999);
         addEffect("blue","colormatrix",[0.5,0.5,0.5,0,-255,0.5,0.5,0.5,0,-170,0.5,0.5,0.5,0,0,0,0,0,1,0],null,999);
         addEffect("red","colormatrix",[0.5,0.5,0.5,0,0,0.5,0.5,0.5,0,-170,0.5,0.5,0.5,0,-170,0,0,0,1,0],null,999);
         addEffect("green","colormatrix",[0.5,0.5,0.5,0,-170,0.5,0.5,0.5,0,0,0.5,0.5,0.5,0,-170,0,0,0,1,0],null,999);
      }
      
      private static function addEffect(param1:String, param2:String, param3:Array, param4:String, param5:int = 0) : void
      {
         if(_availableEffectNames.indexOf(param1) >= 0)
         {
            UnknownVarFromCameraEffect_Map_1[param1] = new CameraEffect(param1,param2,param3,param4,param5);
         }
      }
      
      public function getEffectStrength() : Number
      {
         return value / UnknownVarFromCameraEffect_Int_1;
      }
      
      public function allowsOnlyOneInstance() : Boolean
      {
         return type == "frame";
      }
      
      public function usesEffectStrength() : Boolean
      {
         return type != "frame";
      }
      
      public function getColorMatrixFilter(param1:Boolean = false) : BitmapFilter
      {
         var _loc5_:int = 0;
         if(param1)
         {
            return new ColorMatrixFilter(matrixArray);
         }
         var _loc4_:Array = [];
         var _loc3_:Array = [1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0];
         _loc5_ = 0;
         while(_loc5_ < matrixArray.length)
         {
            _loc4_.push(matrixArray[_loc5_] * getEffectStrength() + _loc3_[_loc5_] * (1 - getEffectStrength()));
            _loc5_++;
         }
         return new ColorMatrixFilter(_loc4_);
      }
      
      public function setChosen(param1:Boolean) : void
      {
         var _loc3_:IRegionWindow = null;
         var _loc2_:IWindowModel = null;
         isOn = param1;
         if(button)
         {
            setSelectionHighlight(isOn);
            _loc3_ = button.findChildByName("remove_effect_button") as IRegionWindow;
            _loc3_.visible = isOn;
            if(!allowsOnlyOneInstance())
            {
               _loc2_ = button.findChildByName("active_indicator") as IWindowModel;
               _loc2_.visible = isOn;
            }
         }
      }
      
      private function setSelectionHighlight(param1:Boolean) : void
      {
         var _loc2_:IWindowModel = null;
         if(button)
         {
            _loc2_ = button.findChildByName("selected_indicator") as IWindowModel;
            _loc2_.visible = param1;
         }
      }
      
      public function turnOffHighlight() : void
      {
         setSelectionHighlight(false);
      }
   }
}

