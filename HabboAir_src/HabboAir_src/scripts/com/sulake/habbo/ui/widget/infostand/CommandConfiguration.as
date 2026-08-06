package com.sulake.habbo.ui.widget.infostand
{
   import flash.utils.Dictionary;
   
   public class CommandConfiguration
   {
      private var _allCommandIds:Array;
      
      private var UnknownVarFromCommandConfiguration_Dictionary_1:Dictionary;
      
      public function CommandConfiguration(param1:Array, param2:Array)
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         UnknownVarFromCommandConfiguration_Dictionary_1 = new Dictionary();
         super();
         _allCommandIds = param1;
         while(_loc3_ < param2.length)
         {
            _loc4_ = int(param2[_loc3_]);
            UnknownVarFromCommandConfiguration_Dictionary_1[_loc4_] = true;
            _loc3_++;
         }
      }
      
      public function get allCommandIds() : Array
      {
         return _allCommandIds;
      }
      
      public function isEnabled(param1:int) : Boolean
      {
         return UnknownVarFromCommandConfiguration_Dictionary_1[param1] != null;
      }
   }
}

