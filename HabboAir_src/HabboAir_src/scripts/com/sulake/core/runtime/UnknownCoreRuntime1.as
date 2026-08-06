package com.sulake.core.runtime
{
   [SecureSWF(rename="true")]
   public class UnknownCoreRuntime1 implements IUnknownCoreRuntime1_1
   {
      public function UnknownCoreRuntime1()
      {
         super();
      }
      
      public function logError(param1:String, param2:Boolean, param3:int = -1, param4:Error = null) : void
      {
         Logger.log(param1,param4 != null ? param4.getStackTrace() : "");
      }
      
      public function set errorLogger(param1:IUnknownCoreRuntime1_2) : void
      {
      }
   }
}

