// import { useState } from "react";
// import Header from "../controller/header";
// import Sidebar from "../controller/sidebar";


// export default function Dashboard() {
//   const [sidebarOpen, setSidebarOpen] = useState(false);

//   return (
//     <div className="min-h-screen bg-gray-100">
//       <Header onToggle={() => setSidebarOpen(true)} />
//       <Sidebar
//         isOpen={sidebarOpen}
//         onClose={() => setSidebarOpen(false)}
//       />

//       {/* Main Content */}
//       <main className="pt-6 md:ml-64 px-4 md:px-6">
//         <h1 className="text-2xl font-bold mb-6">Dashboard</h1>

//         <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
//           <div className="bg-white p-6 rounded-xl shadow hover:shadow-md transition">
//             <p className="text-gray-500">Total Topics</p>
//             <h2 className="text-3xl font-bold text-indigo-600 mt-1">8</h2>
//           </div>

//           <div className="bg-white p-6 rounded-xl shadow hover:shadow-md transition">
//             <p className="text-gray-500">Total Notes</p>
//             <h2 className="text-3xl font-bold text-blue-600 mt-1">120</h2>
//           </div>

//           <div className="bg-white p-6 rounded-xl shadow hover:shadow-md transition">
//             <p className="text-gray-500">Published Notes</p>
//             <h2 className="text-3xl font-bold text-green-600 mt-1">98</h2>
//           </div>
//         </div>
//       </main>
//     </div>
//   );
// }



import { useState } from "react";
import Header from "../controller/header";
import Sidebar from "../controller/sidebar";

export default function Dashboard() {
  const [sidebarOpen, setSidebarOpen] = useState(false);

  return (
    <div className="min-h-screen bg-gray-100">
      {/* HEADER */}
      <Header onToggle={() => setSidebarOpen(true)} />

      {/* BODY */}
      <div className="flex h-[calc(100vh-4rem)]">
        {/* SIDEBAR */}
        <Sidebar
          isOpen={sidebarOpen}
          onClose={() => setSidebarOpen(false)}
        />

        {/* MAIN CONTENT */}
        <main className="flex-1 overflow-y-auto p-6">
          <h1 className="text-2xl font-bold mb-6">Dashboard</h1>

          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            <div className="bg-white p-6 rounded-xl shadow">
              <p className="text-gray-500">Total Topics</p>
              <h2 className="text-3xl font-bold text-indigo-600 mt-1">
                8
              </h2>
            </div>

            <div className="bg-white p-6 rounded-xl shadow">
              <p className="text-gray-500">Total Notes</p>
              <h2 className="text-3xl font-bold text-blue-600 mt-1">
                120
              </h2>
            </div>

            <div className="bg-white p-6 rounded-xl shadow">
              <p className="text-gray-500">Published Notes</p>
              <h2 className="text-3xl font-bold text-green-600 mt-1">
                98
              </h2>
            </div>
          </div>
        </main>
      </div>
    </div>
  );
}
