// import { useState } from "react";
// import { Link } from "react-router-dom";

// export default function Header({ onToggle }) {
//   const [open, setOpen] = useState(false);

//   return (
//     <header className="h-16 bg-gradient-to-r from-indigo-600 to-blue-600 text-white flex items-center justify-between px-4 md:px-6 shadow">
      
//       {/* Left: Logo + Toggle */}
//       <div className="flex items-center gap-3">
//         {/* Mobile Toggle */}
//         <button
//           className="md:hidden text-2xl"
//           onClick={onToggle}
//         >
//           ☰
//         </button>

//         <Link to="/admin/dashboard" className="text-lg font-bold">
//           MyNotes Admin
//         </Link>
//       </div>

//       {/* Right: Profile */}
//       <div className="relative">
//         <div
//           onClick={() => setOpen(!open)}
//           className="flex items-center gap-3 cursor-pointer"
//         >
//           <span className="hidden sm:block font-medium">Admin</span>
//           <img
//             src="https://i.pravatar.cc/40"
//             className="w-9 h-9 rounded-full border-2 border-white"
//             alt="admin"
//           />
//         </div>

//         {/* Dropdown */}
//         {open && (
//           <div className="absolute right-0 mt-3 w-52 bg-white text-gray-800 rounded-xl shadow-xl overflow-hidden">
//             <div className="px-4 py-3 border-b">
//               <p className="font-semibold">Admin</p>
//               <p className="text-sm text-gray-500">admin@notes.com</p>
//             </div>

//             <button className="block w-full text-left px-4 py-2 hover:bg-gray-100">
//               Edit Profile
//             </button>

//             <button className="block w-full text-left px-4 py-2 text-red-500 hover:bg-gray-100">
//               Logout
//             </button>
//           </div>
//         )}
//       </div>
//     </header>
//   );
// }




import { useState } from "react";

export default function Header({ onToggle }) {
  const [open, setOpen] = useState(false);

  return (
    <header className="h-16 bg-gradient-to-r from-indigo-600 to-blue-600 text-white flex items-center justify-between px-4 md:px-6 shadow">
      
      {/* Left */}
      <div className="flex items-center gap-3">
        {/* Toggle only on mobile */}
        <button
          className="md:hidden text-2xl"
          onClick={onToggle}
        >
          ☰
        </button>
        <h1 className="font-bold text-lg">My Notes Admin</h1>
      </div>

      {/* Right */}
      <div className="relative">
        <div
          onClick={() => setOpen(!open)}
          className="flex items-center gap-3 cursor-pointer"
        >
          <span className="hidden sm:block font-medium">Admin</span>
          <img
            src="https://i.pravatar.cc/40"
            alt="admin"
            className="w-9 h-9 rounded-full border-2 border-white"
          />
        </div>

        {open && (
          <div className="absolute right-0 mt-3 w-48 bg-white text-gray-800 rounded-xl shadow-lg overflow-hidden">
            <div className="px-4 py-3 border-b">
              <p className="font-semibold">Admin</p>
              <p className="text-sm text-gray-500">admin@notes.com</p>
            </div>

            <button className="block w-full text-left px-4 py-2 hover:bg-gray-100">
              Edit Profile
            </button>

            <button className="block w-full text-left px-4 py-2 text-red-500 hover:bg-gray-100">
              Logout
            </button>
          </div>
        )}
      </div>
    </header>
  );
}
