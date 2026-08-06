package com.sulake.habbo.window.theme
{
   import com.sulake.core.window.enum.PivotPoint;
   import com.sulake.core.window.graphics.SkinContainer;
   import com.sulake.core.window.theme.IPropertyMap;
   import com.sulake.core.window.theme.IThemeManager;
   import com.sulake.core.window.theme.PropertyMap;
   import com.sulake.core.window.theme.UnknownCoreWindowTheme1;
   import com.sulake.core.window.utils.TextStyleManager;
   import com.sulake.habbo.window.widgets.IlluminaBorderWidget;
   import com.sulake.habbo.window.widgets.WidgetClasses;
   import flash.utils.Dictionary;
   
   public class ThemeManager implements IThemeManager
   {
      private static const UnknownConstFromThemeManager_Int_1:int = 100;
      
      private static const THEMES:Array = ["None","Volter","Ubuntu","Misc","Illumina Light","Illumina Dark","Icon","Legacy border"];
      
      private var _themes:Dictionary;
      
      private var UnknownVarFromThemeManager_SkinContainer_1:SkinContainer;
      
      public function ThemeManager(param1:SkinContainer)
      {
         var _loc5_:PropertyMap = null;
         var _loc3_:PropertyMap = null;
         super();
         UnknownVarFromThemeManager_SkinContainer_1 = param1;
         _loc5_ = new PropertyMap();
         _loc5_.addBoolean("always_show_selection",false);
         _loc5_.addEnumeration("antialias_type","advanced",["normal","advanced"]);
         _loc5_.addString("asset_uri",null);
         _loc5_.addBoolean("auto_arrange_items",true);
         _loc5_.addEnumeration("auto_size","none",["none","left","center","right"]);
         _loc5_.addString("bitmap_asset_name",null);
         _loc5_.addEnumeration("fill_mode","stretch",["stretch","tile","center","cover","contain"]);
         _loc5_.addBoolean("border",false);
         _loc5_.addHex("border_color",0);
         _loc5_.addBoolean("condense_white",false);
         _loc5_.addBoolean("container_resize_to_columns",false);
         _loc5_.addEnumeration("direction","down",["up","down","left","right"]);
         _loc5_.addBoolean("display_as_password",false);
         _loc5_.addBoolean("display_raw",false);
         _loc5_.addBoolean("editable",true);
         _loc5_.addHex("etching_color",0);
         _loc5_.addBoolean("fit_size_to_contents",false);
         _loc5_.addBoolean("flip_x",false);
         _loc5_.addBoolean("flip_y",false);
         _loc5_.addBoolean("focus_capturer",false);
         _loc5_.addHex("color1",4294967295);
         _loc5_.addHex("color2",4278190080);
         _loc5_.addEnumeration("mode","linear",["linear","radial"]);
         _loc5_.addBoolean("greyscale",false);
         _loc5_.addEnumeration("grid_fit_type","pixel",["pixel","none","subpixel"]);
         _loc5_.addBoolean("handle_bitmap_disposing",true);
         _loc5_.addString("help_page","");
         _loc5_.addEnumeration("link_target","default",["default","_blank","_parent","_self","_top","internal"]);
         _loc5_.addInt("spacing",0);
         _loc5_.addInt("margin_left",0);
         _loc5_.addInt("margin_top",0);
         _loc5_.addInt("margin_right",0);
         _loc5_.addInt("margin_bottom",0);
         _loc5_.addInt("max_chars",0);
         _loc5_.addInt("max_lines",0);
         _loc5_.addArray("item_array",[]);
         _loc5_.addBoolean("mouse_wheel_enabled",true);
         _loc5_.addBoolean("multiline",false);
         _loc5_.addEnumeration("pivot_point",PivotPoint.PIVOT_NAMES[0],UnknownCoreWindowTheme1.PIVOT_POINT_RANGE);
         _loc5_.addInt("pointer_offset",0);
         _loc5_.addNumber("radius",0);
         _loc5_.addBoolean("resize_on_item_update",false);
         _loc5_.addBoolean("inverse_resize_on_item_update",false);
         _loc5_.addString("restrict",null);
         _loc5_.addBoolean("scale_to_fit_items",false);
         _loc5_.addString("scrollable","");
         _loc5_.addBoolean("selectable",true);
         _loc5_.addEnumeration("shape","rectangle",["rectangle","round_rectangle","ellipse","rhombus"]);
         _loc5_.addString("sides","all");
         _loc5_.addHex("stroke_color",4278190080);
         _loc5_.addNumber("stroke_hsv_shade",0);
         _loc5_.addNumber("stroke_thickness",0);
         _loc5_.addBoolean("stretched_x",true);
         _loc5_.addBoolean("stretched_y",true);
         _loc5_.addHex("text_color",0);
         _loc5_.addEnumeration("text_style","regular",TextStyleManager.getStyleNameArrayRef());
         _loc5_.addBoolean("tint",false);
         _loc5_.addString("tool_tip_caption","");
         _loc5_.addUint("tool_tip_delay",500);
         _loc5_.addBoolean("tool_tip_is_dynamic",false);
         _loc5_.addBoolean("interactive_cursor_disabled",false);
         _loc5_.addBoolean("vertical",false);
         _loc5_.addEnumeration("widget_type","",WidgetClasses.WIDGET_TYPES);
         _loc5_.addBoolean("word_wrap",false);
         _loc5_.addNumber("zoom_x",1);
         _loc5_.addNumber("zoom_y",1);
         _loc5_.addBoolean("open_upward",false);
         _loc5_.addBoolean("keep_open_on_deactivate",false);
         _loc5_.addInt("padding_horizontal",6);
         _loc5_.addInt("padding_vertical",6);
         _loc5_.addString("overflow_replace","");
         _loc5_.addBoolean("wrap_x",false);
         _loc5_.addBoolean("wrap_y",false);
         _loc5_.addNumber("rotation",0);
         _loc5_.addEnumeration("illumina_border:border_style","illumina_light",IlluminaBorderWidget.BORDER_STYLES);
         _themes = new Dictionary();
         _themes["None"] = new Theme("None",false,0,4294967295,_loc5_);
         var _loc4_:int = 0;
         while(UnknownVarFromThemeManager_SkinContainer_1.skinRendererExists(1,_loc4_))
         {
            _loc4_++;
         }
         _themes["Icon"] = new Theme("Icon",false,0,_loc4_,_loc5_);
         var _loc2_:int = 0;
         while(UnknownVarFromThemeManager_SkinContainer_1.skinRendererExists(30,_loc2_) && _loc2_ < 100)
         {
            _loc2_++;
         }
         _themes["Legacy border"] = new Theme("Legacy border",false,0,_loc2_,_loc5_);
         _themes["Volter"] = new Theme("Volter",true,0,3,_loc5_.clone());
         _loc3_ = _loc5_.clone();
         _loc3_.addEnumeration("antialias_type","advanced",["normal","advanced"]);
         _loc3_.addEnumeration("text_style","u_regular",TextStyleManager.getStyleNameArrayRef());
         _themes["Ubuntu"] = new Theme("Ubuntu",true,3,5,_loc3_);
         _themes["Misc"] = new Theme("Misc",true,10000,8,_loc3_.clone());
         _loc3_ = _loc5_.clone();
         _loc3_.addEnumeration("antialias_type","advanced",["normal","advanced"]);
         _loc5_.addHex("etching_color",3003121663);
         _loc3_.addEnumeration("text_style","il_regular",TextStyleManager.getStyleNameArrayRef());
         _themes["Illumina Light"] = new Theme("Illumina Light",true,100,100,_loc3_);
         _loc3_ = _loc3_.clone();
         _loc5_.addEnumeration("illumina_border:border_style","illumina_dark",IlluminaBorderWidget.BORDER_STYLES);
         _themes["Illumina Dark"] = new Theme("Illumina Dark",true,200,100,_loc3_);
      }
      
      public function getStyle(param1:String, param2:uint, param3:String) : uint
      {
         var _loc4_:int = 0;
         var _loc6_:* = 0;
         if(param1 == "None")
         {
            return int(param3);
         }
         var _loc5_:Theme = _themes[param1];
         if(_loc5_ == null)
         {
            return 0;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc5_.styleCount)
         {
            _loc6_ = uint(_loc5_.baseStyle + _loc4_);
            if(param3 == UnknownVarFromThemeManager_SkinContainer_1.getIntentByTypeAndStyle(param2,_loc6_))
            {
               return _loc6_;
            }
            _loc4_++;
         }
         return _loc5_.baseStyle;
      }
      
      public function getThemeAndIntent(param1:uint, param2:uint) : Object
      {
         var _loc4_:String = UnknownVarFromThemeManager_SkinContainer_1.getIntentByTypeAndStyle(param1,param2);
         if(param1 == 1)
         {
            return {
               "theme":"Icon",
               "intent":_loc4_
            };
         }
         if(param1 == 30 && param2 < 100)
         {
            return {
               "theme":"Legacy border",
               "intent":_loc4_
            };
         }
         for each(var _loc3_ in _themes)
         {
            if(_loc3_.isReal && _loc3_.coversStyle(param2))
            {
               return {
                  "theme":_loc3_.name,
                  "intent":_loc4_
               };
            }
         }
         return {
            "theme":"None",
            "intent":_loc4_
         };
      }
      
      public function getIntents(param1:uint, param2:String, param3:uint) : Array
      {
         var _loc6_:Theme = null;
         var _loc5_:int = 0;
         var _loc7_:String = null;
         var _loc4_:Array = [];
         if(param2 != "None")
         {
            _loc6_ = _themes[param2];
            _loc5_ = 0;
            while(_loc5_ < _loc6_.styleCount)
            {
               _loc7_ = UnknownVarFromThemeManager_SkinContainer_1.getIntentByTypeAndStyle(param1,_loc6_.baseStyle + _loc5_);
               if(_loc7_ != null)
               {
                  _loc4_.push(_loc7_);
               }
               _loc5_++;
            }
         }
         if(_loc4_.length == 0)
         {
            _loc4_.push(param3.toString());
         }
         return _loc4_;
      }
      
      public function getPropertyDefaults(param1:uint) : IPropertyMap
      {
         var _loc2_:PropertyMap = null;
         for each(var _loc3_ in _themes)
         {
            if(_loc3_.isReal && _loc3_.coversStyle(param1))
            {
               _loc2_ = _loc3_.propertyDefaults;
               break;
            }
         }
         if(_loc2_ == null)
         {
            _loc2_ = new PropertyMap();
         }
         return _loc2_;
      }
      
      public function getThemes() : Array
      {
         return THEMES;
      }
   }
}

