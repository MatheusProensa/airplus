package com.sulake.habbo.window.theme
{
   import com.sulake.core.window.theme.PropertyMap;
   
   public class Theme
   {
      public static const NONE:String = "None";
      
      public static const ICON:String = "Icon";
      
      public static const LEGACY_BORDER:String = "Legacy border";
      
      public static const VOLTER:String = "Volter";
      
      public static const UBUNTU:String = "Ubuntu";
      
      public static const MISC:String = "Misc";
      
      public static const ILLUMINA_LIGHT:String = "Illumina Light";
      
      public static const ILLUMINA_DARK:String = "Illumina Dark";
      
      private var _name:String;
      
      private var _isReal:Boolean;
      
      private var _baseStyle:uint;
      
      private var _styleCount:uint;
      
      private var _propertyDefaults:PropertyMap;
      
      public function Theme(param1:String, param2:Boolean, param3:uint, param4:uint, param5:PropertyMap)
      {
         super();
         _name = param1;
         _isReal = param2;
         _baseStyle = param3;
         _styleCount = param4;
         _propertyDefaults = param5;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get isReal() : Boolean
      {
         return _isReal;
      }
      
      public function get baseStyle() : uint
      {
         return _baseStyle;
      }
      
      public function get styleCount() : uint
      {
         return _styleCount;
      }
      
      public function get propertyDefaults() : PropertyMap
      {
         return _propertyDefaults;
      }
      
      public function coversStyle(param1:uint) : Boolean
      {
         return param1 >= _baseStyle && param1 < _baseStyle + _styleCount;
      }
   }
}

