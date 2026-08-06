package com.sulake.core.utils
{
   public class ErrorReportStorage
   {
      private static var UnknownVarFromErrorReportStorage_Map_1:Map = new Map();
      
      private static var UnknownVarFromErrorReportStorage_Map_2:Map = new Map();
      
      public function ErrorReportStorage()
      {
         super();
      }
      
      public static function getDebugData() : String
      {
         var _loc2_:int = 0;
         var _loc1_:String = "";
         _loc2_ = 0;
         while(_loc2_ < UnknownVarFromErrorReportStorage_Map_2.length)
         {
            if(_loc2_ == 0)
            {
               _loc1_ = UnknownVarFromErrorReportStorage_Map_2.getWithIndex(_loc2_);
            }
            else
            {
               _loc1_ = _loc1_ + " ** " + UnknownVarFromErrorReportStorage_Map_2.getWithIndex(_loc2_);
            }
            _loc2_++;
         }
         if(_loc1_.length > 400)
         {
            _loc1_ = _loc1_.substr(_loc1_.length - 400);
         }
         return _loc1_;
      }
      
      public static function addDebugData(param1:String, param2:String) : void
      {
         UnknownVarFromErrorReportStorage_Map_2.remove(param1);
         UnknownVarFromErrorReportStorage_Map_2.add(param1,param2);
      }
      
      public static function setParameter(param1:String, param2:String) : void
      {
         UnknownVarFromErrorReportStorage_Map_1[param1] = param2;
      }
      
      public static function getParameter(param1:String) : String
      {
         return UnknownVarFromErrorReportStorage_Map_1[param1];
      }
      
      public static function getParameterNames() : Array
      {
         return UnknownVarFromErrorReportStorage_Map_1.getKeys();
      }
   }
}

