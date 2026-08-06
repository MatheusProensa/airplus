package com.sulake.habbo.roomevents.wired_setup.uibuilder.params
{
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   
   public class SectionParam
   {
      public static var UnknownVarFromSectionParam_Int_1:int = 0;
      
      public static var UnknownVarFromSectionParam_Int_2:int = 1;
      
      public static var UnknownVarFromSectionParam_Int_3:int = 2;
      
      public static var DEFAULT:SectionParam = new SectionParam(null,0);
      
      public static var COLLAPSED:SectionParam = new SectionParam(null,1);
      
      public static var UnknownVarFromSectionParam_SectionParam_1:SectionParam = new SectionParam(null,2);
      
      private var _miscHeaderOptions:Array = [];
      
      private var _expandMode:int;
      
      private var _sourceTypeSelectorParam:SourceTypeSelectorParam;
      
      private var _headerOptionLeft:WiredUIPreset;
      
      private var _titleYOffset:int;
      
      public function SectionParam(param1:SourceTypeSelectorParam = null, param2:int = 0, param3:WiredUIPreset = null, param4:int = 0)
      {
         super();
         _expandMode = param2;
         _sourceTypeSelectorParam = param1;
         _headerOptionLeft = param3;
         _titleYOffset = param4;
      }
      
      public function get expandMode() : int
      {
         return _expandMode;
      }
      
      public function get sourceTypeSelectorParam() : SourceTypeSelectorParam
      {
         return _sourceTypeSelectorParam;
      }
      
      public function set expandMode(param1:int) : void
      {
         _expandMode = param1;
      }
      
      public function set sourceTypeSelectorParam(param1:SourceTypeSelectorParam) : void
      {
         _sourceTypeSelectorParam = param1;
      }
      
      public function addHeaderOption(param1:WiredUIPreset) : void
      {
         _miscHeaderOptions.push(param1);
      }
      
      public function get miscHeaderOptions() : Array
      {
         return _miscHeaderOptions;
      }
      
      public function get headerOptionLeft() : WiredUIPreset
      {
         return _headerOptionLeft;
      }
      
      public function get titleYOffset() : int
      {
         return _titleYOffset;
      }
      
      public function set headerOptionLeft(param1:WiredUIPreset) : void
      {
         _headerOptionLeft = param1;
      }
      
      public function set titleYOffset(param1:int) : void
      {
         _titleYOffset = param1;
      }
   }
}

