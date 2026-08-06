package
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   public interface IHabboLoadingScreen extends IComponentInterfaceQueue
   {
      function updateLoadingBar(param1:Number) : void;
      
      function showError(param1:String) : void;
   }
}

