package com.sulake.habbo.ui.widget.chatinput.habbiconselector
{
   public class HabbiconSelectorSection
   {
      public var type:String;
      
      public var key:String;
      
      public var title:String;
      
      public var entries:Array;
      
      public function HabbiconSelectorSection(param1:String, param2:String, param3:String, param4:Array)
      {
         super();
         this.type = param1;
         this.key = param2;
         this.title = param3;
         this.entries = param4;
      }
   }
}

