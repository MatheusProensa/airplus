package com.sulake.habbo.roomevents.wired_setup.uibuilder.params
{
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   
   public class CheckboxOptionParam
   {
      private var _text:String;
      
      private var _id:int = -1;
      
      private var _iconAssetName:String;
      
      private var _extra1:WiredUIPreset;
      
      private var _extra2:WiredUIPreset;
      
      public function CheckboxOptionParam(param1:String, param2:int = -1, param3:WiredUIPreset = null, param4:WiredUIPreset = null)
      {
         super();
         _text = param1;
         _id = param2;
         _extra1 = param3;
         _extra2 = param4;
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function get iconAssetName() : String
      {
         return _iconAssetName;
      }
      
      public function set iconAssetName(param1:String) : void
      {
         _iconAssetName = param1;
      }
      
      public function get extra1() : WiredUIPreset
      {
         return _extra1;
      }
      
      public function set extra1(param1:WiredUIPreset) : void
      {
         _extra1 = param1;
      }
      
      public function get extra2() : WiredUIPreset
      {
         return _extra2;
      }
      
      public function set extra2(param1:WiredUIPreset) : void
      {
         _extra2 = param1;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function set id(param1:int) : void
      {
         _id = param1;
      }
   }
}

