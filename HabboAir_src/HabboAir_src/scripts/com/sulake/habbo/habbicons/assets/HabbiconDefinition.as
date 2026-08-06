package com.sulake.habbo.habbicons.assets
{
   public class HabbiconDefinition
   {
      public var previewWidth:int;
      
      public var previewHeight:int;
      
      public var direction:int;
      
      public var animated:Boolean;
      
      public var loop:Boolean;
      
      public var frames:Array;
      
      public var steps:Array;
      
      public function HabbiconDefinition(param1:int, param2:int, param3:int, param4:Boolean, param5:Boolean, param6:Array, param7:Array)
      {
         super();
         this.previewWidth = param1;
         this.previewHeight = param2;
         this.direction = param3;
         this.animated = param4;
         this.loop = param5;
         this.frames = param6;
         this.steps = param7;
      }
   }
}

