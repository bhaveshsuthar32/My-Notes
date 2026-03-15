// import { Link } from "react-router-dom";

// export default function Sidebar() {
//   return (
//     <aside className="w-64 bg-white border-r min-h-screen hidden md:block">
//       <nav className="p-5 space-y-2 text-sm">
//         <Link
//           to="/admin/dashboard"
//           className="block px-4 py-2 rounded-lg hover:bg-blue-50 text-gray-700"
//         >
//           📊 Dashboard
//         </Link>

//         <Link
//           to="/admin/users"
//           className="block px-4 py-2 rounded-lg hover:bg-blue-50 text-gray-700"
//         >
//           👤 Users
//         </Link>

//         <Link
//           to="/admin/topics"
//           className="block px-4 py-2 rounded-lg hover:bg-blue-50 text-gray-700"
//         >
//           📚 Notes Type (Topics)
//         </Link>

//         <Link
//           to="/admin/notes"
//           className="block px-4 py-2 rounded-lg hover:bg-blue-50 text-gray-700"
//         >
//           📝 Notes List
//         </Link>

//         <Link
//           to="/admin/notes/create"
//           className="block px-4 py-2 rounded-lg hover:bg-blue-50 text-gray-700"
//         >
//           ➕ Add New Note
//         </Link>
//       </nav>
//     </aside>
//   );
// }



// import { NavLink } from "react-router-dom";

// export default function Sidebar({ isOpen, onClose }) {
//   return (
//     <>
//       {/* Mobile overlay */}
//       {isOpen && (
//         <div
//           className="fixed inset-0 bg-black/40 z-40 md:hidden"
//           onClick={onClose}
//         />
//       )}

//       <aside
//         className={`fixed md:static z-50 top-0 left-0 h-full w-64
//         bg-gradient-to-b from-indigo-600 to-blue-600 text-white
//         transform transition-transform duration-300
//         ${isOpen ? "translate-x-0" : "-translate-x-full md:translate-x-0"}`}
//       >
//         {/* Brand */}
//         <div className="h-16 flex items-center justify-center text-xl font-bold border-b border-white/20">
//           Admin Panel
//         </div>

//         {/* Menu */}
//         <nav className="p-4 space-y-2 text-sm">
          
//           <NavLink
//             to="/admin/dashboard"
//             className={({ isActive }) =>
//               `flex items-center gap-3 px-4 py-3 rounded-xl font-medium transition-all
//               ${
//                 isActive
//                   ? "bg-white text-indigo-700 shadow"
//                   : "text-white hover:bg-white/20"
//               }`
//             }
//           >
//             📊 <span>Dashboard</span>
//           </NavLink>

//           <NavLink
//             to="/admin/users"
//             className={({ isActive }) =>
//               `flex items-center gap-3 px-4 py-3 rounded-xl font-medium transition-all
//               ${
//                 isActive
//                   ? "bg-white text-indigo-700 shadow"
//                   : "text-white hover:bg-white/20"
//               }`
//             }
//           >
//             👤 <span>Users</span>
//           </NavLink>

//           <NavLink
//             to="/admin/topics"
//             className={({ isActive }) =>
//               `flex items-center gap-3 px-4 py-3 rounded-xl font-medium transition-all
//               ${
//                 isActive
//                   ? "bg-white text-indigo-700 shadow"
//                   : "text-white hover:bg-white/20"
//               }`
//             }
//           >
//             📚 <span>Notes Type</span>
//           </NavLink>

//           <NavLink
//             to="/admin/notes"
//             className={({ isActive }) =>
//               `flex items-center gap-3 px-4 py-3 rounded-xl font-medium transition-all
//               ${
//                 isActive
//                   ? "bg-white text-indigo-700 shadow"
//                   : "text-white hover:bg-white/20"
//               }`
//             }
//           >
//             📝 <span>Notes List</span>
//           </NavLink>

//           <NavLink
//             to="/admin/notes/create"
//             className={({ isActive }) =>
//               `flex items-center gap-3 px-4 py-3 rounded-xl font-medium transition-all
//               ${
//                 isActive
//                   ? "bg-white text-indigo-700 shadow"
//                   : "text-white hover:bg-white/20"
//               }`
//             }
//           >
//             ➕ <span>Add Note</span>
//           </NavLink>

//         </nav>
//       </aside>
//     </>
//   );
// }

import { NavLink } from "react-router-dom";

export default function Sidebar({ isOpen, onClose }) {
  return (
    <>
      {/* Overlay for mobile */}
      {isOpen && (
        <div
          onClick={onClose}
          className="fixed inset-0 bg-black/40 z-40 md:hidden"
        />
      )}

      <aside
        className={`
          fixed md:static z-50 top-0 left-0
          h-full w-64
          border-r-[1px]
          border-solid
          border-slate-400
         bg-slate-100
          transform transition-transform duration-300
          ${isOpen ? "translate-x-0" : "-translate-x-full md:translate-x-0"}
        `}
            // bg-gradient-to-b from-indigo-600 to-blue-600 text-white
      >
        <div className="h-16 flex items-center justify-center text-xl font-bold border-b border-white/20">
          Admin Panel
        </div>

        <nav className="p-4 space-y-2 text-sm">
          {[
            { to: "/admin/dashboard", label: "Dashboard", icon: "📊" },
            { to: "/admin/users", label: "Users", icon: "👤" },
            { to: "/admin/topics", label: "Notes Type", icon: "📚" },
            { to: "/admin/notes", label: "Notes List", icon: "📝" },
            { to: "/admin/notes/create", label: "Add Note", icon: "➕" },
            { to: "/" ,label : "Home", icon : "🏠" }
          ].map((item, i) => (
            <NavLink
              key={i}
              to={item.to}
              onClick={onClose}
              className={({ isActive }) =>
                `
                flex items-center gap-3 px-4 py-3 rounded-xl font-medium
                transition-all
                ${
                  isActive
                    ? "bg-white text-indigo-700 shadow"
                    : "hover:bg-white/20"
                }
              `
              }
            >
              <span className="text-lg">{item.icon}</span>
              {item.label}
            </NavLink>
          ))}
        </nav>
      </aside>
    </>
  );
}
