package com.sulake.core.communication
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.connection.SocketConnection;
   import com.sulake.core.communication.connection.UnknownICoreCommunicationConnection1;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.runtime.IProfiler_1;
   
   [SecureSWF(rename="true")]
   public class CoreCommunicationManager extends Component implements ICoreCommunicationManager, IProfiler_1
   {
      private var UnknownVarFromCoreCommunicationManager_Array_1:Array;
      
      public function CoreCommunicationManager(param1:IComponent_2, param2:uint = 0)
      {
         super(param1,param2);
         UnknownVarFromCoreCommunicationManager_Array_1 = [];
         registerUpdateReceiver(this,0);
      }
      
      override public function dispose() : void
      {
         removeUpdateReceiver(this);
         for each(var _loc1_ in UnknownVarFromCoreCommunicationManager_Array_1)
         {
            _loc1_.dispose();
         }
         UnknownVarFromCoreCommunicationManager_Array_1 = null;
         super.dispose();
      }
      
      public function createConnection(param1:UnknownICoreCommunicationConnection1 = null) : IConnection
      {
         var _loc2_:IConnection = new SocketConnection(this,param1);
         UnknownVarFromCoreCommunicationManager_Array_1.push(_loc2_);
         return _loc2_;
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:int = 0;
         var _loc3_:IConnection = null;
         _loc2_ = 0;
         while(_loc2_ < UnknownVarFromCoreCommunicationManager_Array_1.length)
         {
            _loc3_ = UnknownVarFromCoreCommunicationManager_Array_1[_loc2_];
            _loc3_.processReceivedData();
            if(disposed)
            {
               return;
            }
            if(_loc3_.disposed)
            {
               UnknownVarFromCoreCommunicationManager_Array_1.splice(_loc2_,1);
            }
            else
            {
               _loc2_++;
            }
         }
      }
   }
}

