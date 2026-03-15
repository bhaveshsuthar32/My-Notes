// import Navbar from "../../components/navbar";

// export default function Notes() {
//   return (
//     <>
//     <Navbar />
//     <div className="min-h-screen bg-gray-50 px-4 py-8">
//       {/* Main Container */}
//       <div className="max-w-3xl mx-auto bg-white rounded-2xl shadow-sm overflow-hidden">
        
//         {/* Cover Image */}
//         <img
//           src="https://images.unsplash.com/photo-1515879218367-8466d910aaa4"
//           alt="Note Cover"
//           className="w-full h-64 object-cover"
//         />

//         {/* Content */}
//         <div className="p-6 md:p-10">
          
//           {/* Topic Badge */}
//           <span className="inline-block bg-blue-100 text-blue-700 text-sm font-medium px-3 py-1 rounded-full mb-4">
//             Programming / NodeJS
//           </span>

//           {/* Title */}
//           <h1 className="text-3xl md:text-4xl font-bold text-gray-900 leading-tight">
//             Understanding Event Loop in NodeJS
//           </h1>

//           {/* Sub Heading */}
//           <p className="text-gray-600 mt-3 text-lg">
//             How NodeJS handles asynchronous operations efficiently
//           </p>

//           {/* Meta Info */}
//           <div className="flex gap-4 text-sm text-gray-500 mt-4">
//             <span>📅 Jan 20, 2026</span>
//             <span>⏱ 6 min read</span>
//           </div>

//           {/* Divider */}
//           <hr className="my-8" />

//           {/* Paragraph */}
//           <p className="text-gray-800 leading-relaxed text-base mb-6">
//             The event loop is what allows NodeJS to perform non-blocking
//             I/O operations, despite the fact that JavaScript is single-threaded.
//             It works by offloading operations to the system kernel whenever possible.
//           </p>

//           <p className="text-gray-800 leading-relaxed text-base mb-6">
//             Understanding the event loop is essential for writing efficient
//             and scalable backend applications using NodeJS.
//           </p>

//           {/* Bullet Points */}
//           <h2 className="text-xl font-semibold text-gray-900 mb-3">
//             Key Points to Remember
//           </h2>

//           <ul className="list-disc list-inside text-gray-800 space-y-2 mb-8">
//             <li>NodeJS runs on a single-threaded event loop</li>
//             <li>Non-blocking I/O improves performance</li>
//             <li>Callbacks, Promises and Async/Await use the event loop</li>
//             <li>Heavy computation should be avoided on main thread</li>
//           </ul>

//           {/* Special Notes Box */}
//           <div className="bg-red-500 text-white rounded-xl p-5 mb-8">
//             <h3 className="font-semibold text-lg mb-2">
//               ⚠️ Special Note
//             </h3>
//             <p className="leading-relaxed">
//               Never block the event loop with synchronous operations.
//               It can significantly degrade application performance
//               and affect all users.
//             </p>
//           </div>

//           {/* Another Paragraph */}
//           <p className="text-gray-800 leading-relaxed text-base">
//             In real-world applications, understanding how asynchronous
//             code is executed will help you debug performance issues
//             and write cleaner, more maintainable code.
//           </p>
//         </div>
//       </div>
//     </div>
//     </>
//   );
// }



import { useState } from "react";
import Navbar from "../../components/navbar";

const chapters = [
  {
    id: 1,
    title: "Introduction to Event Loop",
    content: (
      <>
        <p className="mb-4">
          The event loop is what allows NodeJS to perform non-blocking I/O
          operations, even though JavaScript is single-threaded.
        </p>
        <p className="mb-4">
          It delegates heavy tasks to the system and executes callbacks
          once the task is completed.
        </p>
           <p className="mb-4">
          It delegates heavy tasks to the system and executes callbacks
          once the task is completed.
        </p>
           <p className="mb-4">
          It delegates heavy tasks to the system and executes callbacks
          once the task is completed.
        </p>
           <p className="mb-4">
          It delegates heavy tasks to the system and executes callbacks
          once the task is completed.
        </p>
           <p className="mb-4">
          It delegates heavy tasks to the system and executes callbacks
          once the task is completed.
        </p>
           <p className="mb-4">
          It delegates heavy tasks to the system and executes callbacks
          once the task is completed.
        </p>
      </>
    ),
  },
  {
    id: 2,
    title: "How Event Loop Works",
    content: (
      <>
        <p className="mb-4">
          The event loop continuously checks the call stack and task queue.
        </p>
        <ul className="list-disc list-inside mb-4">
          <li>Call Stack</li>
          <li>Callback Queue</li>
          <li>Microtask Queue</li>
        </ul>
      </>
    ),
  },
  {
    id: 3,
    title: "Best Practices",
    content: (
      <>
        <p className="mb-4">
          Avoid blocking the event loop with synchronous code.
        </p>

        <div className="bg-red-500 text-white p-4 rounded-xl">
          <strong>⚠️ Special Note:</strong>
          <p className="mt-2">
            Blocking the event loop affects all users using the application.
          </p>
        </div>
      </>
    ),
  },
];

export default function Notes() {
  const [currentPage, setCurrentPage] = useState(0);

  const nextPage = () => {
    if (currentPage < chapters.length - 1) {
      setCurrentPage(currentPage + 1);
    }
  };

  const prevPage = () => {
    if (currentPage > 0) {
      setCurrentPage(currentPage - 1);
    }
  };

  return (
    <>
            <Navbar />
    <div className="min-h-screen bg-gray-100 flex">
      {/* LEFT SIDEBAR (Book Index) */}
      <aside className="hidden md:block w-72 bg-white border-r p-6">
        <h2 className="text-lg font-semibold mb-4">📘 NodeJS Notes</h2>
        <ul className="space-y-3">
          {chapters.map((ch, index) => (
            <li
              key={ch.id}
              onClick={() => setCurrentPage(index)}
              className={`cursor-pointer p-2 rounded-lg transition
                ${
                  currentPage === index
                    ? "bg-blue-100 text-blue-700 font-medium"
                    : "hover:bg-gray-100"
                }`}
            >
              {index + 1}. {ch.title}
            </li>
          ))}
        </ul>
      </aside>

      {/* RIGHT CONTENT (Reading Page) */}
      <main className="flex-1 px-4 py-6 md:px-10">
        <div className="max-w-3xl mx-auto bg-white rounded-2xl shadow-sm overflow-hidden">
          {/* Cover Image */}
          <img
            src="https://images.unsplash.com/photo-1515879218367-8466d910aaa4"
            alt="Cover"
            className="w-full h-56 object-cover"
          />

          {/* Content */}
          <div className="p-6 md:p-10">
            {/* Topic */}
            <span className="inline-block bg-blue-100 text-blue-700 px-3 py-1 rounded-full text-sm mb-4">
              Programming / NodeJS
            </span>

            {/* Title */}
            <h1 className="text-3xl font-bold text-gray-900 mb-2">
              {chapters[currentPage].title}
            </h1>

            {/* Meta */}
            <div className="text-sm text-gray-500 mb-6">
              Page {currentPage + 1} of {chapters.length}
            </div>

            {/* Chapter Content */}
            <div className="text-gray-800 leading-relaxed text-base">
              {chapters[currentPage].content}
            </div>

            {/* Navigation */}
            <div className="flex justify-between items-center mt-10">
              <button
                onClick={prevPage}
                disabled={currentPage === 0}
                className={`px-4 py-2 rounded-lg border ${
                  currentPage === 0
                    ? "opacity-40 cursor-not-allowed"
                    : "hover:bg-gray-100"
                }`}
              >
                ⬅ Previous
              </button>

              <button
                onClick={nextPage}
                disabled={currentPage === chapters.length - 1}
                className={`px-4 py-2 rounded-lg border ${
                  currentPage === chapters.length - 1
                    ? "opacity-40 cursor-not-allowed"
                    : "hover:bg-gray-100"
                }`}
              >
                Next ➡
              </button>
            </div>
          </div>
        </div>
      </main>
    </div>
    </>
  );
}
