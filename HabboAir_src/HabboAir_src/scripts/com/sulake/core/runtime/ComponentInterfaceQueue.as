package com.sulake.core.runtime
{
   [SecureSWF(rename="true")]
   internal class ComponentInterfaceQueue implements IComponentInterfaceQueue
   {
      private var _identifier:IID;
      
      private var _disposed:Boolean;
      
      private var _receivers:Vector.<Function>;
      
      public function ComponentInterfaceQueue(param1:IID)
      {
         super();
         _identifier = param1;
         _receivers = new Vector.<Function>();
         _disposed = false;
      }
      
      public function get identifier() : IID
      {
         return _identifier;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get receivers() : Vector.<Function>
      {
         return _receivers;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _disposed = true;
            _identifier = null;
            while(_receivers.length > 0)
            {
               _receivers.pop();
            }
            _receivers = null;
         }
      }
   }
}

