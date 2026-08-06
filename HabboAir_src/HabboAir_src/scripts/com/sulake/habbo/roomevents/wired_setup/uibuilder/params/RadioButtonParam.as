package com.sulake.habbo.roomevents.wired_setup.uibuilder.params
{
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   
   public class RadioButtonParam
   {
      private var _id:int;
      
      private var _text:String;
      
      private var _iconAssetName:String;
      
      private var _extra1:WiredUIPreset;
      
      private var _extra2:WiredUIPreset;
      
      private var _newLine:Boolean;
      
      public function RadioButtonParam(param1:int, param2:String, param3:WiredUIPreset = null, param4:WiredUIPreset = null, param5:Boolean = false)
      {
         super();
         this._id = param1;
         this._text = param2;
         _extra1 = param3;
         _extra2 = param4;
         _newLine = param5;
      }
      
      public function get id() : int
      {
         return _id;
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
      
      public function get newLine() : Boolean
      {
         return _newLine;
      }
      
      public function set newLine(param1:Boolean) : void
      {
         _newLine = param1;
      }
   }
}

